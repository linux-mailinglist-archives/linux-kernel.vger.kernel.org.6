Return-Path: <linux-kernel+bounces-171768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D928BE848
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2585C28E45E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864316E88F;
	Tue,  7 May 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="LCRfNwUJ"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6116D9CF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097872; cv=none; b=BE3PEDtgVWV3BWxkJMdv/RO+NgvbkMPyaY+g7w6E5dgCm587Wz4HLOkXwT0KYfaMrGcJCMgLgI/dYquBhh91r+L/2IMKqE60F2ns2vnwlEcfRxQoRgmSlPFp3xKWQVOB6oVMb+HlJM+fXATRGSgsV4OqlFFhL/I9DniGcBH0hHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097872; c=relaxed/simple;
	bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k36iL2+lNnViA9YBWhMpwSGfI7jCi80IbjcXvpurhCgwdy8pzYYUDC5BVr6M1ZthHbwBiGr9k4y5cJI3Gd5tEFgbg15sgqfbNBG2Sh6vdMYj1NoDKP8zcKEtaVw1OC1LFy5Lp65SWioJIKrMeVHAH+yxUiw/21812Wjo8DhYWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=LCRfNwUJ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1715097861; x=1715357061;
	bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LCRfNwUJcfxw8j5uQkm8O7ZAAUE7E/wYfXATKO1eIehjOLJdumGkVyvTLnVJQQ7Hs
	 uuKLoFcX8MpDLfuxKURyOnxwpDpWPdmRv83N6FMihU3EBOXAnH9FgqRBKPwVf8D2+U
	 jGtBxNxq2EeYfqfwJum/3nPXyFhulaTpDet2N826eQFIUxt+Od+QuGdXP1isan9/qZ
	 q/HnmMTT+aVa6ZERRlwNOREKwcUVvehwKbGN9osRCztN4LYQcf+cZ4AB0sZyn48dBf
	 UPwngKdXYb6uPxkWPphGHtOGm3hR0QiMBw9UqF/n45J0bBHN0Mf2UMBpS6o0Lq0JZW
	 PWG7RYGLta3xg==
Date: Tue, 07 May 2024 16:04:16 +0000
To: Douglas Anderson <dianders@chromium.org>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Pekka Paalanen <pekka.paalanen@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: Add \n to message about demoting connector force-probes
Message-ID: <7lwNFVPA030n26PAZv7ytBIPJ0TF5vhOTJ-3zO8Dv-b9Qeq2VIuvkdO02CIVPpi1_yK5LhMps0XXxoHayuziNAX8qO4Lh46JD67uI1Bih3M=@emersion.fr>
In-Reply-To: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
References: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: e017d48aa9559bc79337b2e7433d51f8970bb030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Simon Ser <contact@emersion.fr>

