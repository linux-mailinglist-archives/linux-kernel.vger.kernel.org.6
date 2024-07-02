Return-Path: <linux-kernel+bounces-238393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E449249DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE61F22D08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9536201278;
	Tue,  2 Jul 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MPNAq3Uv"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157EA201266
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955292; cv=none; b=uEw12IdWUiNJAhG24sQk0vqdymLnVdbheF+iKRSMVoA+YB5JgKrEVxAwtiG/H79Yy6jjFmvsibEycVEKm1ceHT++TeNJEDKvFx0SNB2faOf8hCfrO2zHrGhDijQe4VQXqHoX2un9UkqoAEjGWp3w9pA0WnEcCVdxf5NV5EsDy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955292; c=relaxed/simple;
	bh=UZrjuqTxW6QUVrcYwX1/P3jWeGcBUNRMKKVT6250cWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs+ltL7q6jQP3qjdU9chdeTh113et9eTaeJDVriBfhULia4PlOvUxXufKz/IdsNJxxCGiSGJsYfvdDe43h/9vbWhwZ5+69PO16kdWzEi8XgYdj7MBQXtZSrWsrLO4dR4Sbkl1tOtN0MBNXUUCX+FuN7P/Pdu7X709PhFDNkq8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MPNAq3Uv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MESlvtfXbQ729zT8sO/kuiEOGD2hkKiKDI3CLSHjPYo=; b=MPNAq3UvUAIQ7J+eR/adP5imXa
	QDPxuaYJB2PM/jsNmCK/eFDMG26a2ERzzOC/SCEHC824Qp5XGWfFjBGKQayE0mstFAalIV7tE0Vjo
	coL15QcpuBcozhGcVHJ2spk4t1T66XgSw7e8eRLCeN0pyPABZY6tdpk4fTnhVvfglPH8ou4B6vvRs
	EacKBGfyc1OfPIJvvHlB6Su8lbYFsFKueejUJb++/OfmMfA/DfpHUL+HCODw7oEAqVD8MVrn7WAJT
	g55cLdbJbQM/IaS5vIVGmPsujtvsFXEQX5oQDOVp0uUcowaDuFOoYPaYO0kGaREjI177Vj7jYxFiK
	WYNyTZug==;
Received: from [191.19.134.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sOkw9-00ASd6-HK; Tue, 02 Jul 2024 23:21:17 +0200
Message-ID: <435dc750-5123-483c-848b-c71b970096da@igalia.com>
Date: Tue, 2 Jul 2024 18:21:10 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with
 atomic async flips
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
 Daniel Stone <daniel@fooishbar.org>, =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?=
 <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>,
 ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>,
 Joshua Ashton <joshua@froggi.es>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240622170951.738735-1-andrealmeid@igalia.com>
 <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 29/06/2024 12:32, Simon Ser escreveu:
> On Saturday, June 22nd, 2024 at 19:09, André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Allow userspace to use explicit synchronization with atomic async flips.
>> That means that the flip will wait for some hardware fence, and then
>> will flip as soon as possible (async) in regard of the vblank.
> 
> LGTM.

thanks!

> 
> Would you mind sending a patch for FB_DAMAGE_CLIPS as well?

sure :)

> 
> Reviewed-by: Simon Ser <contact@emersion.fr>
> 

