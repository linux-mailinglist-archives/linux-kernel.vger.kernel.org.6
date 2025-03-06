Return-Path: <linux-kernel+bounces-549235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D573A54F65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EED5188DD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D220F072;
	Thu,  6 Mar 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="brRj7c4d"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F0148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275876; cv=none; b=oadhNTkeOKY4q8Grosm3Emn33dR88GimrEaC7tlwpQMLMs1omWeWW/wFgvmAIQMNJ+rESJPWGKRoARjxPfaNGy3mrm5HyeVDbSCFVisLscXrelc4Vu6WokPPdMEup8U6mjM7xHE9EmF4I9tHVRn4JoPnENhy6HcY9W7ps5ddZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275876; c=relaxed/simple;
	bh=biIdFna/grGJzohmgaav9daJeJSsg/TtEXlTlxgdbVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cp1SPvBVuUYFRetm+akxxWnsCT7LxQmAgha8Ihazrd7hxNinYw767yNVxYmU9Oi/7eU9/EZ9YvaurZUp5w8Qzf5jX23N2sqIqtO5PTExm/r+B3MYXpG+AbNSTmstzyO61rQHHl1ToJ0bQmHYH6wFfJRXZYR2jEBvy9uF0mIBe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=brRj7c4d; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z7tyK4Gwpz9t32;
	Thu,  6 Mar 2025 16:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741275865; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biIdFna/grGJzohmgaav9daJeJSsg/TtEXlTlxgdbVA=;
	b=brRj7c4dQxY7MnwR/0peFKx9+sNJ13pfqEB5h3zgR1Ti2TthLNJt+FN0ci6y4kigUsThb8
	qI+Kwf89ovsbIiiR/oBYyD0vQpbggxTvmlgC1YKxw/h7OnZ2Xx/8KRosNi2sTGQRuft5PR
	qIgvvz5FFTkYC8/6F+iD7m3MG2l8vB/9iKeEpj1LeL30JuPTXrCEvMsI2kuSDyjHJ3j0qX
	ulEkmga6UFqoUlWXzeTHlBoC/0VvZCSVq4dA5UHQxe/HofvnSleqrfleT7yQrw+Hq6DvAt
	hGmnYZAQLQI22UIqLUaUNcOhlWZ4AveBO60fnoWcUp0ruv1Oa5ZKcbO7khYL9Q==
Message-ID: <748519f2ce93d2692c1f32a6ca0950304a3000fa.camel@mailbox.org>
Subject: Re: [PATCH v7 0/3] drm/sched: Documentation and refcount
 improvements
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 06 Mar 2025 16:44:21 +0100
In-Reply-To: <Z8mxFslgK-XE3EEX@cassiopeiae>
References: <20250305130551.136682-2-phasta@kernel.org>
	 <Z8mxFslgK-XE3EEX@cassiopeiae>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 330f8306d4355ca7471
X-MBO-RS-META: ex6q1jypofhiuswrwh6cggk6tory7phb

On Thu, 2025-03-06 at 15:28 +0100, Danilo Krummrich wrote:
> On Wed, Mar 05, 2025 at 02:05:49PM +0100, Philipp Stanner wrote:
> > Philipp Stanner (3):
> > =C2=A0 drm/sched: Adjust outdated docu for run_job()
> > =C2=A0 drm/sched: Document run_job() refcount hazard
> > =C2=A0 drm/sched: Update timedout_job()'s documentation
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Applied to drm-misc-next.

Thanks

