Return-Path: <linux-kernel+bounces-419267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B499D6B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3D42816D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0219CCF4;
	Sat, 23 Nov 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="naskpoMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75014EC47;
	Sat, 23 Nov 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732396552; cv=none; b=q0bRq7B2/YsxDujcmQshIHFDQpUzP5s2f0oPHi7YNatfzRHIjsQTyzmYfXAH1nx+3PKxl7y7qsue2ZinhZC/h5PyVvXue6lKk7xwCBOEU1cbRfgNhuQKdIhqzlgPOry0HCG0aDt7fbT/Fqw97Qgsc5SQexQyPcnFVkD5zUeN0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732396552; c=relaxed/simple;
	bh=h0h+hDb4VW6ozUvsiOaPXvEKqo5oeZCNGb062sMuQq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3YmqOZZPmZmWA6/s6VoR3u22dh8Ph/bMFP+EcEIjsCDLVqQP/qvHdFo6C+ELF6luJ1l8TbwImLXi9A7Zo99uK4fNzYX58dQkAFyiKwtE5B84UfGtRUersJbX4k2ZsXUtFqUWgSNCtlGMWWaMlpGG6mF47+3Vi8UJz61O3AW/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=naskpoMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADECC4CECF;
	Sat, 23 Nov 2024 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732396552;
	bh=h0h+hDb4VW6ozUvsiOaPXvEKqo5oeZCNGb062sMuQq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naskpoMNnWJlwyB382ijy2G0xXJ+QZEaz6IngKYy7f4rhCPGdrabFiZZ5l1xidAjc
	 g5scG1bK5kL2+7i5KP23bkPbKAnhKeLsF0bFkg/nR2Pnsj9Lnfa5WQpf60P90Azx3E
	 DNsPdBkiCXrmxk+1uvPDwVbqDmmUpN61YkTFXWfo=
Date: Sat, 23 Nov 2024 22:15:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
Message-ID: <2024112335-liver-reclining-a95d@gregkh>
References: <20241123133041.16042-1-sedat.dilek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123133041.16042-1-sedat.dilek@gmail.com>

On Sat, Nov 23, 2024 at 02:29:28PM +0100, Sedat Dilek wrote:
> Rename from "Samsung Backlight driver" to "Samsung Laptop driver".
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  drivers/platform/x86/samsung-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wow, does anyone still use this thing?  Anyway, looks good:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

