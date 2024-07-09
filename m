Return-Path: <linux-kernel+bounces-246106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFFE92BDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93021C21D20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C719CCF4;
	Tue,  9 Jul 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XTIoUTUC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED843147;
	Tue,  9 Jul 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537217; cv=none; b=ZOK9AH2dP2kA8ogKtOUa90aFMyfoE2khNa2Tw87wx3ZBDgizO3KYzrWycQqamebS/xk5SMripPZelXvCXEisD3qIgvl4K+rEcSoT6Pvm9f72x2HfA3vhLwmgYocvDYd5l44jYAU8Eni1rGpyhYChO4htyIrwc0QfUqNmgUpsoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537217; c=relaxed/simple;
	bh=JiW69Fz66dH9tgT9IJ3kGFv2cPDr8WCP9lwPp3BIadc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MiXu+FTHjaAOuRjQsu41/Ewvvy4fST3tZGdojmjaUFTFozfhDiZH0EC5MKBtHco6G4YUOL0YgpgF6DGFCdf+xETuMgamwcIY0FLCnwRSmHuHa+jmEyWMHnmyYPHLl/KPNxNUeVgGbtYztfgjIHPZCikVWOvcvcaCgwelFFG3SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XTIoUTUC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E13141A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720537215; bh=w7U51+W3a2iY26LqogPIRTKUQM3cm8SRY2qgrigSplU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XTIoUTUC9LA0ptJLnNBtG+uS7FLx3uNQtp5V4uyJCqyKfBXZJiSPmpNh3aUtVKLR5
	 A0/XOVQPYab/TFQT5mEEcdlJM855FZcpqXnfrI8I18kj3e9HDZ2vWKvPl7+ACOfPBP
	 lKfJkwINRudB0kWkXBDcHf78dPRcU+4gL5HDnkP8FlxagtDt2iYyTxKoxwSbOxAlc1
	 HVAYYPueN415heiHNWU6Yw1eeBGStuk7clPQKxTZ9DmlBOzYusvyPFKRzo+emvvi4z
	 S9FxXExmlu+On/WOU75E9KORRoCu2uvDItHHSGwafOxrfeXLA6E/eI61JaQK8V+ZXh
	 LYcKsRS8b/jbA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9E13141A36;
	Tue,  9 Jul 2024 15:00:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Lublin <daniel@lublin.se>
Cc: Daniel Lublin <daniel@lublin.se>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: add reference from dynamic debug to
 loglevel kernel params
In-Reply-To: <4633bdb82c1c7c014d79840887878624a55c59f8.1720533043.git.daniel@lublin.se>
References: <4633bdb82c1c7c014d79840887878624a55c59f8.1720533043.git.daniel@lublin.se>
Date: Tue, 09 Jul 2024 09:00:14 -0600
Message-ID: <87plrm8vb5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Lublin <daniel@lublin.se> writes:

> This is useful information for somebody who has managed to dig into
> enabling debug output, but is wondering why there is no such output
> appearing on the console.
>
> Signed-off-by: Daniel Lublin <daniel@lublin.se>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 0e9b48daf690..7c036590cd07 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -26,6 +26,11 @@ Dynamic debug provides:
>     - format string
>     - class name (as known/declared by each module)
>  
> +NOTE: To actually get the debug-print output on the console, you may
> +need to adjust the kernel ``loglevel=``, or use ``ignore_loglevel``.
> +Read about these kernel parameters in
> +Documentation/admin-guide/kernel-parameters.rst.
> +

I've applied this, thanks.

jon

