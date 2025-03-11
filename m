Return-Path: <linux-kernel+bounces-555544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B706CA5B956
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE5C170FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D11F4C98;
	Tue, 11 Mar 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="alMQCAXr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE01211C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675326; cv=none; b=aoO/9UlE4PVRmbZ9Gg3aWAH9MZbBaPgc1++2B6EWh86Hz/rSA7QqmjooQA3bIkpLaS8KFzVb6b5ffko6OTS3JGmgVxll4IUHNxGY7E/57rkBfWp0Pdr6HWY4FQB75IN+73+viYuwhYNq1V81Mt4DrLKleQV8NqHpObfecLqXPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675326; c=relaxed/simple;
	bh=LMpwWjErgNSrltM818IfpyXUndu5mDihR9dssRKnOU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1RrmPvBUAfVRiWmk3Te9ySAGcrJ3UomDsavuosq0h7wIounp0GkJBAISgHOE6c8uJ7ok3dtL61D7PaN/FzPSMs8lOM7XzkDyf8ZO1E3XinO/0D24cqSAUvDl5J2D8IZCiSF2jWoTXlUcW+brHe1LKDhLt3eQRVgjB/4nwwY9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=alMQCAXr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741675322;
	bh=LMpwWjErgNSrltM818IfpyXUndu5mDihR9dssRKnOU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=alMQCAXr85OXh/piMTCKAETgxh1II08hPYLZQSQyFd15wv575ruFteU7vXq9OEFG/
	 qixNy2jvaxhBrOvU3yVUFVf5jts+4UVFvnueWw17FDzR42oP/12EXDMQQhypE/s6qi
	 XDahUvxmgcTP9cRVDSvMi6n38fqj6ez/7U1VAxW9AmuPnZ966svBPD5RPwG4PdpP6e
	 gHo3wz+7ezNPoqBjsoEHe8L923PVbLYn6k2TL5/Wa5+KLtKnY6K16rd1Outx0ceyCQ
	 CbNQFCzVFm7YAqQWIEueaRbgrvaTDqNsXGIKNtgj6dZJkzUYE8o4oPIgtHgqHexyax
	 JwvtySpmfbJ1w==
Received: from [10.20.66.114] (unknown [103.163.65.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4B1C17E05A6;
	Tue, 11 Mar 2025 07:41:59 +0100 (CET)
Message-ID: <ad38518b-e335-4006-a04c-e15a6ef21694@collabora.com>
Date: Tue, 11 Mar 2025 12:11:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ci: use shallow clone to avoid timeouts
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 robdclark@gmail.com, dmitry.baryshkov@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-kernel@vger.kernel.org
References: <20250228151217.563807-1-vignesh.raman@collabora.com>
 <CAPj87rOT36e3TwZwk8uGUNpSz0kGB_XUY2gbCvGYYy2Xguqv5A@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rOT36e3TwZwk8uGUNpSz0kGB_XUY2gbCvGYYy2Xguqv5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/03/25 13:55, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Fri, 28 Feb 2025 at 15:12, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> The python-artifacts job has a timeout of 10 minutes, which causes
>> build failures as it was unable to clone the repository within the
>> specified limits. Set GIT_DEPTH to 50 to speed up cloning and avoid
>> build failures due to timeouts when fetching the full repository.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v2:
>>    - Set GIT_DEPTH to 50 to allow the check-patch job to pass
> 
> This sounds a bit fragile to me. Perhaps we need to make the
> check-patch job instead specifically detect that it is missing history
> and unshallow the history a bit more?

Yes, we could do that. The check-patch job timeout is 1h (from gitlab 
project settings) and we can unshallow git history. I will send a
v3 after testing.

Regards,
Vignesh

> 
> Cheers,
> Daniel


