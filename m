Return-Path: <linux-kernel+bounces-534131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFCA4632D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC73516FF14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EAF222575;
	Wed, 26 Feb 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UpbP2YnN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9C221739
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580740; cv=none; b=KAZYsKyd0JynlXhm76Ezp8HTplB4TdvMkEimduGTzvSUuK6Xuk7aUbn8P9P4wTZ1ojG3/bywz4z+Pk9myvmA1i1tBaaHRksSXhkZ467cUX+7UCR5k28mPVhHvP0NpiiQjwMHJbH50EzgE3Jx11QtVUzddQOiNPqtZ74hMlzwC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580740; c=relaxed/simple;
	bh=cxrFdW4W85TSfqEHazRjLD5P2RVkDFfnhP3bByA5Yco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkP0S/qaO5Wnhgm+rnTL8NL08CFFftZHy3drNxcKkj+iT0rDX0PoeyqBDlZsewpJaGZDrXsK52EeoLri6+YSou9T9NuThOXQttCIpijFAes8+/CtSELXV7tJmkg8Lkb2L5iOUYDJKYY4k8uZ83Q/oHcrQU7JDHscLxkCB5gtTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UpbP2YnN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740580737;
	bh=cxrFdW4W85TSfqEHazRjLD5P2RVkDFfnhP3bByA5Yco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UpbP2YnN4u9ZxxJ4JNUzmdfSdhWRQUneuZsTj67QMAO9aHYf0izJerK/SL9RksNVq
	 7hK4s0u3YSbdQt3XJjTmAgX7gfJ3cqSn/dApX11W0LNLblHQfZAXJGUpopBExdPfNj
	 +sFM55Zr7ygAvKZ8tjPi9mZE8zXLBzzsgaZiwweXUOhO9FFheOm/vVZyzUcegZfKZb
	 1gj7A5yVx4kcUzYSk43V4LordayaHQvJlLuYId/4Wu1vYrzDbLjdvgwzCvM2lXraOU
	 gK9isRHiztJzH3N4bxVSjfO1VMoxMc2Pydy7ZroCqcCrUhNguT7OxlIvnO0SXOFQVC
	 UCsj3469WG51Q==
Received: from [192.168.50.250] (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62FD917E065A;
	Wed, 26 Feb 2025 15:38:53 +0100 (CET)
Message-ID: <84bd530c-4fb9-4913-8ee1-78a6a4f46625@collabora.com>
Date: Wed, 26 Feb 2025 20:08:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: fix merge request rules
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 robdclark@gmail.com, dmitry.baryshkov@linaro.org,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-kernel@vger.kernel.org
References: <20250226135415.363605-1-vignesh.raman@collabora.com>
 <CAPj87rNAaPUEmk1edcuHX1+bMWysF=aOMceUsCxnk2SMJUjqKg@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rNAaPUEmk1edcuHX1+bMWysF=aOMceUsCxnk2SMJUjqKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 26/02/25 19:29, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Wed, 26 Feb 2025 at 13:55, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> Merge request pipelines were only created when changes
>> were made to drivers/gpu/drm/ci/, causing MRs that didn't
>> touch this path to break. Fix MR pipeline rules to trigger
>> jobs for all changes.
> 
> Thanks a lot for fixing this up!
> 
>>       # Build everything after someone bypassed the CI
>>       - if: *is-direct-push
>>         when: on_success
> 
> Should these be when: manual? I think it would be good to align with
> the rules we have for Mesa: run automatically for marge-bot and also
> for scheduled pipelines, but in all other cases (MR context but not
> scheduled for merge, direct push to ref, etc) be manual, so we don't
> overwhelm the CI by testing everything everyone pushed.

mesa has on_success for is-direct-push. Should we change it to manual 
here and update the same in mesa ?

If a user creates a MR, should the jobs run automatically, since we do 
not use marge-bot to merge MRs in drm?

I also noticed we need to remove reference to mesa 
(CI_PROJECT_NAMESPACE). I will send v2 with this change.

Regards,
Vignesh

> 
> Cheers,
> Daniel


