Return-Path: <linux-kernel+bounces-314091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18DE96AEBD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B598B22EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE433F9D5;
	Wed,  4 Sep 2024 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa9fJ624"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEA4776E;
	Wed,  4 Sep 2024 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417896; cv=none; b=O8wZt0PDNWI/hBrSREjPOrZD0d2QzwJONAf1CCUKO1dIUyN148wQ0BX28p8iyI3jW0dRiVifaFimLgWqY7NOEOlQkREg1ejEQFMk1sHQk/DR5G5CLS/r9cz/sdJqKMWDtudqV8BkgGqPGcWLZVrsg7p/wXduF9livs2eXWB0gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417896; c=relaxed/simple;
	bh=fogaHN6CdraCTRrLn2ZBcDH/1HrT2GkkyolQ0HFX2y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrMbpwrYdaOdgz0tpRVdqbNUi9G1IU8VdEwhZgs7pUQyv4+D3G2pRVi/ptN63ATUMkrpTzVFlqG2PKWgq8w3Nke19shIpJb0HiBbCjat2Qif5JsukwtDrMBE4jAhMaXtvJzQaXAF+96dxfoygETE9qseLKKitya7eRfm3dQB8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa9fJ624; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D099C4CEC4;
	Wed,  4 Sep 2024 02:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725417895;
	bh=fogaHN6CdraCTRrLn2ZBcDH/1HrT2GkkyolQ0HFX2y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qa9fJ624Gk6q+EjFrmYrV3XNJB2+gocAFRpoa7IqCDl0ONsHEZFMYai0KE0ny51Hs
	 s/Wf5lMWF6LD9Swe+Fv7X7lw9Qc4Cagg2avCCrb9O5rbbj0JKORJeTh7TRmia3iCIT
	 gcOJWZShZEkoNzUhJvkGy28hHJmhybCO4mfXTC2G4fgUJSjPPhW3Ku+Sgy85EfgSK7
	 bWMmBlDia34SNrh5ggoZVYsDkJ+bixmoBy1EDmrYjf4zhVlgCW1Ryiy2tboWeBr12C
	 DxQMjuF2GlokUqgukcyUMdTfBPYCy5WxZZeUSaU4rr8ZDG4woXOIxJCq377DojUUNK
	 p7WSVUUPGQA4Q==
Date: Wed, 4 Sep 2024 04:44:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Advertise b4
Message-ID: <20240904044443.309aabb1@foz.lan>
In-Reply-To: <20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org>
References: <20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 03 Sep 2024 23:42:04 +0100
Mark Brown <broonie@kernel.org> escreveu:

> b4 is now widely used and is quite helpful for a lot of the things that
> submitting-patches covers, let's advertise it to submitters to try to make
> their lives easier and reduce the number of procedural issues maintainers
> see.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index f310f2f36666..4b6904184ad1 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -842,6 +842,16 @@ Make sure that base commit is in an official maintainer/mainline tree
>  and not in some internal, accessible only to you tree - otherwise it
>  would be worthless.
>  
> +
> +Tooling
> +-------
> +
> +Many of the technical aspects of this process can be automated using
> +b4, documented at <https://b4.docs.kernel.org/en/latest/>. This can
> +help with things like tracking dependencies, running checkpatch and
> +with formatting and sending mails.
> +
> +

No need for two blank lines (yeah, there's a mix on this file of using
one or two blank lines for paragraphs).

I would also add quick example(s) on how to use it for common workflows.

>  References
>  ----------
>  
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240903-documentation-b4-advert-18016e83d7d9
> 
> Best regards,



Thanks,
Mauro

