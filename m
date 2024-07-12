Return-Path: <linux-kernel+bounces-250659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C592FAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A681C20F84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314B16F904;
	Fri, 12 Jul 2024 12:53:56 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6716F825;
	Fri, 12 Jul 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788835; cv=none; b=hW8TDWAd8PXG7+rpZ5AaDUj/ksFn8kyXRKR4EhbPdADMLCsdg+8j0dTMdkquZsijmnk+yQs/0dx2P/pxNDh74iDCdbXDGRTbX2PGryLmHa6Q7pCPi57Es9kKgoXzCsLVvm0rAvoWsS85RjHE8zLdFHA3erzUWIAKqmkJnLmMSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788835; c=relaxed/simple;
	bh=h6KohX0t+T5MhYkRxczVmrM30iHYUmmakksBdqyer4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eI7NF38B6qOvEG79YAVyIQKXuBX+5ZkbqdIrVzT9FELz41uCmOBIU7/2Rer+iGQ6dKXlAAwIz1p40w4YQ4fK2YOFFWKzKrAp++hknKOD5owAcm7jpvPFQvI29s4COSnLoU2STQHbgY8IsrT1BjB1YYS6nvMNAbQyCg0XXG1NPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLBNw0FrJz4x04;
	Fri, 12 Jul 2024 22:53:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
In-Reply-To: <c2d64bebc514ca892a12e51a68821a6317048d3a.1720694954.git.christophe.leroy@csgroup.eu>
References: <c2d64bebc514ca892a12e51a68821a6317048d3a.1720694954.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] Documentation/powerpc: Mention 40x is removed
Message-Id: <172078879463.310795.10548340090473025469.b4-ty@ellerman.id.au>
Date: Fri, 12 Jul 2024 22:53:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 12:50:21 +0200, Christophe Leroy wrote:
> Commit 732b32daef80 ("powerpc: Remove core support for 40x") removed 40x.
> 
> Update documentation accordingly.
> 
> 

Applied to powerpc/next.

[1/1] Documentation/powerpc: Mention 40x is removed
      https://git.kernel.org/powerpc/c/90e812ac40c4b813fdbafab22f426fe4cdf840a8

cheers

