Return-Path: <linux-kernel+bounces-530637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9CA4360D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618CD1899AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2524EF96;
	Tue, 25 Feb 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Sfk7hKFc"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD41FCD1F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468250; cv=none; b=dSEprTBeBa/FN8SfIzr3kSsOnW51CVrMz83vuK0I+qOr91DSfWiqzvmhCRJlTBxPm3pUBBoFQCCkvm6BHtV+TJxQjS7bARS75qaGcZ49a+9X7DgCoh4kH4duwdqeQN14RUEUtbi1mEugZ5ht9id2OkpTpmQhkQTr9y3umpfU8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468250; c=relaxed/simple;
	bh=8A1xQGcIAs2ZYkMnIQ6UYkY+g4MrxPs4QsLmhj9ARe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLCjcA3csOaqrwsKRBmhmm8v2R1Be47khceRG69ToO/TiFln2m1WaFyRvnF4mhDLemR/oMCzYubJarHFNM3cApJizig8bbTn5j1/ybCxmfY+1E8it9bQ2T3tYm7w1qz1h8XvnKDsJ07y1q8LxIfiV5llNxzuUT0T5Wprce4r4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Sfk7hKFc; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z28H26Bq3z9sbq;
	Tue, 25 Feb 2025 08:23:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740468238; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A1xQGcIAs2ZYkMnIQ6UYkY+g4MrxPs4QsLmhj9ARe0=;
	b=Sfk7hKFcS8hwS4uK1NnFvZhdUfF+sO1rwNZWnm19iR7UslZzL+xpGoc+UQT8zV3+9Zd85E
	/B6fjo5a+S5WDWLwf3CYFMSqn4GxKu75V31R3teC98xIpvorluXDw6z1mskBkbN7rWVhFS
	DQknCLlnum81mKrrHSnGhiaLmQpyxYuh1tw3spHO6A0aMCJNZkRXixc8bOxqoHNjYtlXra
	/HHCSd4wTqA55ir7l8KAUTKjav+rwl//f/xQhp7gBfoCQ4IJDX29VAnF+hqF4ssq6Lo8rf
	o7CRDoN4DOBL+4xAW44T6b5ruTaTe82baq7sAWPAHZ7f/QNNQdG9dG7+8jZAQQ==
Message-ID: <0bb7b9c428bdefe36afb43272c73da7e04a001ed.camel@mailbox.org>
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Qianyi Liu <liuqianyi125@gmail.com>
Cc: airlied@gmail.com, ckoenig.leichtzumerken@gmail.com, dakr@kernel.org, 
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,  maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com, mripard@kernel.org,  phasta@kernel.org,
 tzimmermann@suse.de
Date: Tue, 25 Feb 2025 08:23:56 +0100
In-Reply-To: <20250225031225.44102-1-liuqianyi125@gmail.com>
References: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
	 <20250225031225.44102-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 04c2cee6b44ee9cd818
X-MBO-RS-META: w44jgfszoj8fo67om5ekqg96r1t3ojsa

On Tue, 2025-02-25 at 11:12 +0800, Qianyi Liu wrote:
> Hello Philipp,
>=20
> Thank you for your patient reply. Let's first clarify the issue and
> send a new
> patch if necessary.
>=20
> As soon as it enters the drm_sched_entity_kill function, the entity
> ->last_scheduled reference count is incremented by 1. If there are
> still jobs in
> the current entity, it will enter the while loop, assuming there is
> only one job
> left. If entity->last_scheduled has already been signaled, it will
> enter
> drm_sched_entity_kill_jobs_cb, but because null is passed in, the
> last_scheduled reference count will not be correctly reduced by 1.
>=20
> Because the prev pointer has been updated to &s_fence->finished, the
> dma_fence_put in the last line only reduces the reference count of
> s_fence->finished.
> The reference count of entity->last_scheduled was not reduced by
> 1, causing a memory leak.
>=20
> We should subtract 1 from the reference count of the prev when
> dma_fence_add_callback
> fails, which is called balance.
>=20
> Best Regards.
> QianYi.

OK, thanks for clarification.

I think, next to the other feedback, it would be good to have a brief
version of the above explanation in your commit message, since this
clearly describes the problem and the proposed solution.

Please address the feedback by Matt and myself in a v2.

(and btw., please don't remove the original e-mail content when
answering =E2=80=93 that's uncommon on-list. Only when the threads are gett=
ing
huge one removes parts not addressed by the answer from the quoted
content ;)


Thanks
P.

