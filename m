Return-Path: <linux-kernel+bounces-430476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD249E315E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D052D1682B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0732374CB;
	Wed,  4 Dec 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A0gvFFur"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14233224FA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278998; cv=none; b=nglCPojj8cUkz1p8Q5h5hH6krbWhZBoFwCRdDLYcjtXMk5HpZjIe+ssRfr126FOtBLnDt9ZORh8zsATk0f5FW3bFL/cXMu6US4YQXTNDyMhwWY1PHyF+4MBITcEr5XzA5ix3HtuD0QAAg5AYWw3CNAzBO/UiRcF0espDpgBdwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278998; c=relaxed/simple;
	bh=hVPWjxDf3J62Z7wnIqQWbdoImqDsRWqpTgW/qaZa0BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWuz2c86mmaTpLHZTBwo92WQuMGtPj/be0o6ZwUq/1xTot8rND3H6klLfPqOYUtmHbVM+W9+AWnbXAaGMmyfrgy3fOJCQ5/qK2Bc4ENCwF2DiCxe+q/R8I/jnGQuWCJFjuiVtSHq/CEiU2MXNN9czqeuGt5rmxK6s4UCy751B8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A0gvFFur; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733278994;
	bh=hVPWjxDf3J62Z7wnIqQWbdoImqDsRWqpTgW/qaZa0BY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A0gvFFurp2Dn6uAuJi/e5zdcYYEKkJJtQlu4JFEHpWCPvSr5lsqsuH2ju7XfY2iTU
	 K+RA40TbSdIXfFTIBaaR55eHenhPEU9YMBzkWuHoEYSU82f6JQyXHIW/48oku0zhXo
	 BSgPE+MSGBzmokhsalyTQXp/K8C888UWi0J4+D3LFv1hOlMQC3lxZnDYaCd5ZHMmO/
	 +wganKwSZNmPAkNP7MTX6ttSkPzCNTx8+RKtCUdnIc6NRcdr0Rxd+tBbVBxhdNZmnI
	 V8hJfQ0+4a1zoVZB67UlJ9zsUWBCErDBmWM7UvxyiAcNNmZ2P/f7T5FZ9Tij93Eaxz
	 lnAg1wwCv2PcA==
Received: from [192.168.50.250] (unknown [171.76.86.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 916CC17E0F8A;
	Wed,  4 Dec 2024 03:23:11 +0100 (CET)
Message-ID: <a9a956b7-55da-4b90-bf82-92def097a63a@collabora.com>
Date: Wed, 4 Dec 2024 07:53:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] drm/ci: uprev mesa and modify gitlab rules
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 daniels <daniels@collabora.com>, airlied <airlied@gmail.com>,
 daniel <daniel@ffwll.ch>, robdclark <robdclark@gmail.com>,
 "guilherme.gallo" <guilherme.gallo@collabora.com>,
 "sergi.blanch.torne" <sergi.blanch.torne@collabora.com>,
 "jani.nikula" <jani.nikula@linux.intel.com>,
 "dmitry.baryshkov" <dmitry.baryshkov@linaro.org>,
 mripard <mripard@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20241128042025.611659-1-vignesh.raman@collabora.com>
 <1938cdd3a4b.10ab98f77527721.7719837795987945098@collabora.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <1938cdd3a4b.10ab98f77527721.7719837795987945098@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Helen,

On 03/12/24 19:42, Helen Mae Koike Fornazier wrote:
> Hi Vignesh,
> 
> Thanks for your patchset.
> 
> 
> 
> ---- On Thu, 28 Nov 2024 01:20:19 -0300 Vignesh Raman  wrote ---
> 
>   > Uprev mesa to adapt to the latest changes in mesa-ci,
>   > including new container jobs and stages. Update the
>   > lava-submit script to align with recent mesa-ci changes
>   > for using LAVA rootfs overlays. Modify gitLab rules
>   > to include scheduled pipelines.
>   >
>   > Pipeline link,
>   > https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1318024
> 
> I see this pipeline has a few failures, most of them are because outdated xfails files and timeouts.
> Could we fix that first? So when we test this patchset we can verify if it introduces any issues or not.

Yes. The expectation files are not updated. I will uprev IGT and rerun 
the tests and update xfails.

Regards,
Vignesh

> 
> Thanks
> Helen
> 
>   >
>   > Vignesh Raman (2):
>   >  drm/ci: uprev mesa
>   >  drm/ci: update gitlab rules
>   >
>   >  drivers/gpu/drm/ci/build.sh       |   2 +-
>   >  drivers/gpu/drm/ci/build.yml      | 104 ++++++++++++++++-
>   >  drivers/gpu/drm/ci/container.yml  |  22 ++--
>   >  drivers/gpu/drm/ci/gitlab-ci.yml  | 185 ++++++++++++++++--------------
>   >  drivers/gpu/drm/ci/image-tags.yml |  11 +-
>   >  drivers/gpu/drm/ci/lava-submit.sh |  99 +++++++++++-----
>   >  drivers/gpu/drm/ci/test.yml       |  33 +++---
>   >  7 files changed, 314 insertions(+), 142 deletions(-)
>   >
>   > --
>   > 2.43.0
>   >
>   >
> 

