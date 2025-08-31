<?php

namespace App\Controller;

use App\Form\UserFormType;
use App\Repository\VideoRepository;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Contracts\Translation\TranslatorInterface;

final class ProfileController extends AbstractController
{
    #[Route('/profile', name: 'app_profile')]
    public function show(TranslatorInterface $translator, VideoRepository $videoRepository): Response
    {
        if(!$this->getUser()){
            $this->addFlash('error',$translator->trans("profileController.show.mustLogin"));
            return $this->redirectToRoute('app_login');
        }
        $videos = $videoRepository->findBy(['user' => $this->getUser()]);
        $videosTotal = sizeof($videos);
        return $this->render('profile/show.html.twig',[
            'videos' => $videos,
            'videosTotal' => $videosTotal
        ]);
    }

    #[Route('/profile/edit', name: "app_profile_edit")]
    public function edit(Request $request, EntityManagerInterface $em, TranslatorInterface $translator): Response{
        if(!$this->getUser()){
            $this->addFlash('error',$translator->trans("profileController.edit.mustLogin"));
            return $this->redirectToRoute('app_login');
        }
        /**
         * @var User
         */
        $user = $this->getUser();
        $form = $this->createForm(UserFormType::class, $user);
        $form->handleRequest($request);
        if($form->isSubmitted() && $form->isValid()){
            $user->setUpdatedAt(new DateTimeImmutable());
            $em->flush();
            $this->addFlash('success', $translator->trans('Profile successfuly updated !'));
            return $this->redirectToRoute('app_profile');
        }
        return $this->render('profile/edit.html.twig', [
                        'user' => $user,
                        'userForm' => $form->createView()
        ]);
    }
}
