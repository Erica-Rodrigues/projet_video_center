<?php

namespace App\Controller;

use App\Entity\Video;
use App\Form\SearchType;
use App\Form\VideoType;
use App\Model\SearchData;
use App\Repository\VideoRepository;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;


final class VideoController extends AbstractController
{
    #[Route(path: '/',name: 'app_video_index', methods: ['GET'])]
    public function index(VideoRepository $videoRepository,PaginatorInterface $paginatorInterface, Request $request): Response
    {
        if($this->getUser()){
            /**
             * @var User
             */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash('info','Your email is not verified !');
            }
        }

        // pour la pagination
        $data = $videoRepository->findAll();
        $videosTotal = sizeof($data);
        $videos = $paginatorInterface->paginate(
            $data,
            $request->query->getInt('page', 1),
            9
        );

        // pour la barre de recherche
        $searchData = new SearchData();
        $form = $this->createForm(SearchType::class, $searchData);
        $form->handleRequest($request);

        if($form->isSubmitted() && $form->isValid()) {
            $searchData->page = $request->query->getInt('page', 1);
            $videos = $videoRepository->findBySearch($searchData);
            $videosTotal = sizeof($videos);

            return $this->render('video/index.html.twig', [
                'form' => $form->createView(),
                'videos' => $videos,
                'videosTotal' => $videosTotal,
                'searchData' => $searchData
            ]);
        }

        return $this->render('video/index.html.twig', [
            'videos' => $videos,
            'form' => $form->createView(),
            'searchData' => $searchData
        ]);
    }

    #[Route('/video/create', name: 'app_video_create', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        if($this->getUser()){
            /**
             * @var User
             */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash('error', 'Your must confirm your email to create a video !');
                return $this->redirectToRoute('app_video_index');
            }
        }else {
            $this->addFlash('error', 'You must login to create a video !');
            return $this->redirectToRoute('app_login');
        }
        $video = new Video;
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUser($this->getUser())
                  ->setCreatedAt(new DateTimeImmutable())
                  ->setUpdatedAt(new DateTimeImmutable());
            $entityManager->persist($video);
            $entityManager->flush();

            return $this->redirectToRoute('app_video_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('video/create.html.twig', [
            'video' => $video,
            'form' => $form,
        ]);
    }

    #[Route('/video/{id}', name: 'app_video_show', methods: ['GET'])]
    public function show(Video $video): Response
    {
        if($this->getUser()){
            /**
             * @var User
             */
            $user = $this->getUser();
            if(!$user->isVerified() && $video->isPremiumVideo()){
                $this->addFlash('error', 'Your must confirm your email to watch this video !');
                return $this->redirectToRoute('app_video_index');
            }
        }else if(!$this->getUser() && $video->isPremiumVideo()) {
            $this->addFlash('error', 'You must login to watch this video !');
            return $this->redirectToRoute('app_login');
        }

        return $this->render('video/show.html.twig', [
            'video' => $video,
        ]);
    }

    #[Route('/video/{id}/edit', name: 'app_video_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    {
        if($this->getUser()){
            /**
             * @var User
             */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash('error', 'You must confirm your email to edit a video !');
                return $this->redirectToRoute('app_video_index');
            }
            if($user->getEmail() != $video->getUser()->getEmail()){
                $this->addFlash('error', 'You must be ' . $video->getUser()->getEmail() . 'to edit this video !');
                return $this->redirectToRoute('app_video_index');
            }
        }else {
            $this->addFlash('error', 'You must login to create a video !');
            return $this->redirectToRoute('app_login');
        }
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUpdatedAt(new DateTimeImmutable());
            $entityManager->flush();

            return $this->redirectToRoute('app_video_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('video/edit.html.twig', [
            'video' => $video,
            'form' => $form,
        ]);
    }

    #[Route('/video/{id}/delete', name: 'app_video_delete')]
    public function delete(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    {
        if($this->getUser()){
            /**
             * @var User
             */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash('error', 'You must confirm your email to delete a video !');
                return $this->redirectToRoute('app_video_index');
            }
            if($user->getEmail() != $video->getUser()->getEmail()){
                $this->addFlash('error', 'You must be ' . $video->getUser()->getEmail() . 'to delete this video !');
                return $this->redirectToRoute('app_video_index');
            }
        }else{
            $this->addFlash('error', 'You must login to delete this video !');
            return $this->redirectToRoute('app_login');
        }
        if ($this->isCsrfTokenValid('delete'.$video->getId(), $request->getPayload()->getString('_token'))) {
            $entityManager->remove($video);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_video_index', [], Response::HTTP_SEE_OTHER);
    }
}
