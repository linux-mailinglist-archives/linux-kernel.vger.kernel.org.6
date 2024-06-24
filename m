Return-Path: <linux-kernel+bounces-227664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6D915534
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33383287C68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2713D633;
	Mon, 24 Jun 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QMoJrn1L"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43F1DA32
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249423; cv=none; b=p/VSJpCEP0xh8/L5kRAs8BvJiP0u2hZF0W2Ejbwz/LPZpl6orBrn333JD2pS+fmdG84U1QYK8sX9V35dMJMH+IY42KCqeI8kotBF+vEGGJGu55ZHL11M7E5p/t04Q48FsdVr9QODtnH/FzompN/Ygyc1N+gxSmrXF3ukxEP5K1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249423; c=relaxed/simple;
	bh=GMEQP3jd8WRb2V1nPNUL0HSascCCaN0HsToYXwfFS2k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EDc0Wc5W3sfkSTdWWaDA+In+AfdsTWPrOAxHP23uoHQgEJNhYzM0ppkE7McqH6GUp+rvGJESvkaHE20b5lxZv7P8934tJbRreZUU8JaSoCvsXnZRDgLS5KdQjIavbBjBv+/nPmRxwfhIpwLhxZFyRnd/v9mUF7v+L53Y9MVEOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QMoJrn1L; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719249403; x=1719854203; i=markus.elfring@web.de;
	bh=GMEQP3jd8WRb2V1nPNUL0HSascCCaN0HsToYXwfFS2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QMoJrn1LD5lVdyjr6qrnNyWBC9Ki0fPFxYP+xV8jVYyKjVESnnioV/BDJTTirsS9
	 GDQIARYffI53kzX88EjdN9KTz0Fuv/tQNQ78sFHto5jSXXBZPMi7SHQyXpU57VrDw
	 wXqeLG7oqcyHV/bE3WQa3+i5mJ6RyiD7sAgfAfCqFs12C8Fz4d+N3zRAa0wWW2s48
	 PHNjCcLZmFNW9e76FRN9lZGMjECc6EcXDGGWURCDWLxomWYSvXTkYWg9WWdgejGKb
	 EfAlspgPvguakHZzls5iavUCbavzqtCJsVP7Q3o3/KtT/tKm2iUSPPuqLZhCCd2kc
	 aGY1Xc1tZIgJYkSLBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1swVhd2Q90-00mAhP; Mon, 24
 Jun 2024 19:16:43 +0200
Message-ID: <8d9791ba-14cf-481f-8964-341880865a0a@web.de>
Date: Mon, 24 Jun 2024 19:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>, George Shen <george.shen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Natanel Roizenman <natanel.roizenman@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20240624024835.2278651-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/amd/display: Check pipe_ctx before it is used
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624024835.2278651-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iYOxbUd/7f3wK5ncEyBEN/Q53syMelXlMbVXqlZkEbL8mvcBZ6k
 ZrOms3leP2hoDMYqxo0dms8w44Dmr/iNZZ7w692BEhxfOZiYi+xgqiYUU6IK2zdnwpbyops
 xRSRpnX319A30gWC1+zvcpJpP+cu0n0yvD4xhJv0mOp98jFlyb8ILsG8sDVsR3Ax31U7R62
 mxwISQHFqPAKYd/Oj/OfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0FDCty/50O4=;LrAnG81ZmgYLa0YVEo58iS38UZ9
 y3xoIvBTWSsZzgqcBjpOBeApuEp38UKLHl/yMigDPUCFljO/tBRQ2fEJfZdGw8bs4jZTpg9Oh
 jfO+oBRhQOFKJLdgAZvmNeg4uds0gUO2pVyLnOBwegymz8jg+ciZeUT03IvKBjniqALbhedFY
 MSF2zaRByPL1srQTxDqI3EOSGXsVP89bPSIp7XEPnwaJc93lP671jA1iE6kJPS/4oqZcogvQR
 cZ5RPnalOZZb/rJRMxZuXFRXmAf2SRe5aorN7al1eHxtK46BR0yxGZbPzblKEZFzdtbyeErUm
 amMoO4byxprl7ZbBE4qFm9LQ4zgt0xbXSQU2f0FJ5C+lDD5+rtlbhZ/xUz5lXpkY8iO+PeOKi
 0ZotloisqAEFfoNiFUWCT/OmB2Rd6LXuMTqH5nOenHlzg649SG8Itg3kZW+o9qXbJ2sJ8pxqB
 FlPBLZL24WZ2dB19zjNv8OBb5Q+SdQ8PALd43U+uP25MW8970VFRI2loz0MWG+YEIF+sGLXwc
 6mijamvwM9Ul4XjWeaqODOLCFOOztr162i8DUKHmA/Hyu+ULnuAyPpkHaPRDXGZ7b2Y6mrYIm
 J4CuPJdQNV1sJh0vgD7VPz552b7NYbc9Bil2KDuHnoVyA6P/Ti2rCPPYKz+kYsT6dbELiUwHt
 ffrJhP0hZeNVP1hLi2qkyekWShsSrmoGDjMACW43n+j0unMm18AR+KzfrxbZabb0G2ZNBr6hj
 heK7Cfn47qc7jnu0W1pMY6RZagmvGypflug/SIc68vhna+hFM9mopX0IRd+UYsH6ZWKa8B3PK
 t8U3DX2Rklww8E3bSirqq52JMdX0ugPNxj9fIG5Vvi+PU=

> resource_get_otg_master_for_stream() could return NULL, we
> should check the return value of 'otg_master' before it is
> used in resource_log_pipe_for_stream().

A similar fix was integrated already according to a contribution
by Natanel Roizenman.
From which Linux version did you take source files for your static code analyses?

Please take another look at the corresponding software update.
[PATCH 16/37] drm/amd/display: Add null check in resource_log_pipe_topology_update
https://lore.kernel.org/amd-gfx/20240422152817.2765349-17-aurabindo.pillai@amd.com/

Regards,
Markus

