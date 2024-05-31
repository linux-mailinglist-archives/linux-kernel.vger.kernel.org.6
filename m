Return-Path: <linux-kernel+bounces-196504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6B8D5D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B7F1C218BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4E155759;
	Fri, 31 May 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvRCfE7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7824E1C8;
	Fri, 31 May 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145364; cv=none; b=AILw7XfyiRZi095CU1YmMc1qmskz7z6waus22jODA0Q7TZ4MZx8WlUKpUL8Z6N/CLeE0tuSP1HoHxGEpvcsH/5YjcXm6W2+i0g1A/MkDQAwqY1kOvn5OFLs0wb95jo6HXuL4nHI0Shd7y5dOTCWFK2KflqPU5bYwxplL1GWtD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145364; c=relaxed/simple;
	bh=/FtTw4L3/0ok1cYl0Gjm/8aHhQtvXipqqU7yEhedizo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PExlfiH5BShp50pxhHEbuvqPuOEtrPQREy7fA8X9gngO0O/wfMdRqRvDx9iHdM/XkhFwgddYGNOrdVYAYzYnRVuH0YQScRZY58jFQPpYCI9Sm2UDx5KdEokV7vEHdSifDYQ8Y+jXweJZLmp2rN4FVMVGjHPaL6ak4BWYQlIsnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvRCfE7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FB7C116B1;
	Fri, 31 May 2024 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717145364;
	bh=/FtTw4L3/0ok1cYl0Gjm/8aHhQtvXipqqU7yEhedizo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvRCfE7WbrXQi8KwK2o0ZsIglFXr9NtNNSrrNtfTij3bF9/EMyMNjrq0LR0LisCGx
	 JIYOMz8arN/UD8LGPJEgJOVkCmS4q4c5xJfSqxlBR+5jqwBGdc8QcsADgk4HlWdqHY
	 CRfqBZjrjuiTsSXsdvL86om0nFZGHCt3spJGAkV65wsoj9B8xu5LQYU2gvyU3VTqTI
	 gSEtUMShd25zmdWE+BUV8oqjsMelW7xVL+T1RoF4tjDSq2EXo8SBmsa8RLa/rgkRDt
	 /AJqDvvlFfWwFfZgrkZOen4FcRKLx41TtX1rJuAhIPk5WcMykaDJwsr2M7NE8L67oq
	 +dtvcPOCTMrBA==
Date: Fri, 31 May 2024 10:49:19 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Danish Prakash <contact@danishpraka.sh>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] scripts/sphinx-pre-install: fix incorrect package names
 for openSUSE
Message-ID: <20240531104919.18504578@coco.lan>
In-Reply-To: <20240531061941.9607-1-contact@danishpraka.sh>
References: <20240531061941.9607-1-contact@danishpraka.sh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Danish,

Em Fri, 31 May 2024 11:49:15 +0530
Danish Prakash <contact@danishpraka.sh> escreveu:

> openSUSE made some changes to python package names in the recent
> past and hence the current information on installing the relevant
> doc-related packages yields no output when run on openSUSE distros.
> Update the package names to the correct ones.
> 
> Signed-off-by: Danish Prakash <contact@danishpraka.sh>
> ---
>  scripts/sphinx-pre-install | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index c1121f098542..56bda8b43a44 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -465,8 +465,8 @@ sub give_redhat_hints()
>  sub give_opensuse_hints()
>  {
>  	my %map = (
> -		"python-sphinx"		=> "python3-sphinx",
> -		"yaml"			=> "python3-pyyaml",
> +		"python-sphinx"		=> "python3-Sphinx",
> +		"yaml"			=> "python3-pyaml",
>  		"virtualenv"		=> "python3-virtualenv",
>  		"dot"			=> "graphviz",
>  		"convert"		=> "ImageMagick",

The best would be to check for the openSUSE version, as otherwise
such change will break for others using older versions.

There are some such checks already for other distros. See, for instance

	sub give_redhat_hints()
	{
	...
	$rel = $1 if ($system_release =~ /release\s+(\d+)/);

        if (!($system_release =~ /Fedora/)) {
		...
	} else {
                if ($rel && $rel < 26) {
                        $old = 1;
                }
                if ($rel && $rel >= 38) {
                        $noto_sans_redhat = "google-noto-sans-cjk-fonts";
                }
        }

There, it handles Fedora different than RHEL/CentOS, and, for Fedora,
it checks the release version to make the code compatible with
different versions.

Regards,
Mauro

