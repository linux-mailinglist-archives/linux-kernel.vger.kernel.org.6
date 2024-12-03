Return-Path: <linux-kernel+bounces-429626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25C89E1EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788EE2842A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C6F1F427C;
	Tue,  3 Dec 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="j7R0Eerv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F81CF8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235146; cv=pass; b=d/ja+vuMpB+CUy/n40TgwPHHH4y40/44bSzyERCkg+J7J0P+vJgbT7hrjB3kEdtAmrR9XWivpAxjWLM7BU5YyZsE1WBb8K9S3hwkTMTOM+DdcADNoG2yp2OuPn4tfapYDm+6ivmU2jWEqM/pwaHaACTJJhhqJhOPDzbLSYIdfkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235146; c=relaxed/simple;
	bh=GeVk0jBBTu6926GI92qEkwVGY1NmoavSZAkCnhuD0Lg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rg1AczqCpQMV43PRONghxS4PnNuP645nQxaCIEDD4qwFd97AW54FIQd1avZNxtZZjscoUvhrXMmOqR0pxZ2d5hbd6A8Rr3CYAzqGr5HDg6iizXmb9bc4WQh8F0E2C6lM8iqoswdrqTjoPwhQaA+baRPyBVIhKUBPw5OzK2l38kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=j7R0Eerv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733235130; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MPZXdW8Y3hPGPnRj2DfwUcn1zkCEX3n+Zyk4APU5ZUhJ2A91OrjUD00lyiFo2EZ4tb9ab8kWl8gA3vlsSBJz0qfX0MY3O5NMvNImZb8iy4DGUF2nGFrQ2xlp3RkZ6pfNbylgBeCHXaPpyW/VZHdu4rssz73l1/KBgMHRo1IjKmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733235130; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7g6w0PTEih4JLogvfupPa5HvZYEHouhugF1ggPgJrp8=; 
	b=HpwgIP1kVbKhgmA76uVmL/tpDTuYDTsA0Iz8ZoLuTDYUa52LDLM0STKXt5s2mRGrxd/UVMMefUDaGKqJ+N6r+lw6JWiJoFo/7fUSsC0Q3Pyq/oweNJLTvkIQMIthjSJsnPnWEOrU1lMylpDhABDOXwSnBsp9zyDobX6GEkWu6RQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733235130;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7g6w0PTEih4JLogvfupPa5HvZYEHouhugF1ggPgJrp8=;
	b=j7R0EervXmxMigrPI6jKVtC803bSeW0USc9iyXP0ynvoVB5iCKOZdZzFhixLql/G
	HZcZaZnQApwkJG8VEdufA2dGcXnm0za/dBItIh9HUmHkFXmHsd2andDRBHgMCzI2K5k
	XcJkc6Fb4qJCWmSSpeo1/axqTSW1iQBXMbRTrOFE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1733235128934380.5176694792625; Tue, 3 Dec 2024 06:12:08 -0800 (PST)
Date: Tue, 03 Dec 2024 11:12:08 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Vignesh Raman" <vignesh.raman@collabora.com>
Cc: "dri-devel" <dri-devel@lists.freedesktop.org>,
	"daniels" <daniels@collabora.com>, "airlied" <airlied@gmail.com>,
	"daniel" <daniel@ffwll.ch>, "robdclark" <robdclark@gmail.com>,
	"guilherme.gallo" <guilherme.gallo@collabora.com>,
	"sergi.blanch.torne" <sergi.blanch.torne@collabora.com>,
	"jani.nikula" <jani.nikula@linux.intel.com>,
	"dmitry.baryshkov" <dmitry.baryshkov@linaro.org>,
	"mripard" <mripard@kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1938cdd3a4b.10ab98f77527721.7719837795987945098@collabora.com>
In-Reply-To: <20241128042025.611659-1-vignesh.raman@collabora.com>
References: <20241128042025.611659-1-vignesh.raman@collabora.com>
Subject: Re: [PATCH v1 0/2] drm/ci: uprev mesa and modify gitlab rules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Vignesh,

Thanks for your patchset.



---- On Thu, 28 Nov 2024 01:20:19 -0300 Vignesh Raman  wrote ---

 > Uprev mesa to adapt to the latest changes in mesa-ci, 
 > including new container jobs and stages. Update the 
 > lava-submit script to align with recent mesa-ci changes 
 > for using LAVA rootfs overlays. Modify gitLab rules 
 > to include scheduled pipelines. 
 >  
 > Pipeline link, 
 > https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1318024 

I see this pipeline has a few failures, most of them are because outdated xfails files and timeouts.
Could we fix that first? So when we test this patchset we can verify if it introduces any issues or not.

Thanks
Helen

 >  
 > Vignesh Raman (2): 
 >  drm/ci: uprev mesa 
 >  drm/ci: update gitlab rules 
 >  
 >  drivers/gpu/drm/ci/build.sh       |   2 +- 
 >  drivers/gpu/drm/ci/build.yml      | 104 ++++++++++++++++- 
 >  drivers/gpu/drm/ci/container.yml  |  22 ++-- 
 >  drivers/gpu/drm/ci/gitlab-ci.yml  | 185 ++++++++++++++++-------------- 
 >  drivers/gpu/drm/ci/image-tags.yml |  11 +- 
 >  drivers/gpu/drm/ci/lava-submit.sh |  99 +++++++++++----- 
 >  drivers/gpu/drm/ci/test.yml       |  33 +++--- 
 >  7 files changed, 314 insertions(+), 142 deletions(-) 
 >  
 > -- 
 > 2.43.0 
 >  
 > 


