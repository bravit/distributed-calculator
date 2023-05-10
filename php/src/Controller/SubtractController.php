<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Response;
use Psr\Log\LoggerInterface;

class SubtractController extends AbstractController
{
    #[Route('/subtract', name: 'subtract')]
    public function subtract(Request $request, LoggerInterface $logger): Response
    {
        $operands = json_decode($request->getContent(), true);
        $logger->info("Subtracting {$operands['operandTwo']} from {$operands['operandOne']} (PHP)");
        return new Response($operands['operandOne'] - $operands['operandTwo']);
    }
}
