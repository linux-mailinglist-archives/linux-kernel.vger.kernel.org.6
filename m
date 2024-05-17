Return-Path: <linux-kernel+bounces-182520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF48C8C49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7591C22555
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86213E032;
	Fri, 17 May 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UBhaBSo6"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0A1A2C19;
	Fri, 17 May 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971019; cv=none; b=sKdjkuKV4Updu0NkmV+ZEk/cMjz+PHHMwjs666qPe4BUwkvQoXIb8k1u6a94Rux5FaNvUn9HIwUon2Y6RdGXgzjqdoYJoxIu2xt+mLgYLAcUCYctEVQ3oc3y8jYgPwrHU/oeSsc2YKVzfnt+z9olghEQ4CHEHzIdGwozhkfWNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971019; c=relaxed/simple;
	bh=4PkvaAcvVDH1aF/nkp65UXl1KU5DOp/JS+CYf98ASLQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HMs0UZr//VlZ2sZxZN2fCjVw9RZ5RsxO6Xk4deM6wbYLBZ4xTli9bg/U4IcCLD03HH/eYhZGzySF9PANE4Ee1qEk2plDUSB18ciOyLPs5ylQIEzOPT7aiDdwGG25pK3Tw2qoNLOXsJ5lBr1t90xHt9NWzktBfVnvfLofHaXjmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UBhaBSo6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715971014; x=1716575814; i=markus.elfring@web.de;
	bh=fB7RALjxdRF1G/aDESbEsQC4h5dPoGC+cUZHy0syvLs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UBhaBSo608yj3CTtHieEr0D2XH77Qz0NO3rHY3B9BxkngkjjIN8pnackHDC2BjGo
	 /DhLJf4Jfiw03YjkkF4pwUxbZh8YL7rkCSCr/9pHOMS/gkaJ0BPjsz03K/GII6CnM
	 wEEoZH3mo77GWLbS2x/4r8VOyXWHXT7A5RYzDyD7yA3b2pg0Ck76BpDjQSeS/yQz3
	 xDDRinhS5FeCqubUDktyvfGLkH2XLEyTQcAB4uJX3jehhV9AV0B6qVtyYaT559Wzq
	 J4PwSRcsu/hcGuG6+59FC89w/v4q+AiZjKYf6R/ETSfr1OFd0KM89Tsi0P3OmRXUN
	 RSL0Qv8SdxdPzib9/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1sbNc00Sxx-00wGrB; Fri, 17
 May 2024 20:30:53 +0200
Message-ID: <94ef2d0b-15d0-4c40-ab52-a5d88a666b3c@web.de>
Date: Fri, 17 May 2024 20:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kuro Chung <kuro.chung@ite.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen Chen <allen.chen@ite.com.tw>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kenneth Haung <kenneth.hung@ite.com.tw>,
 Kuro Chung <kuro.chung@ite.com.tw>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pin-yen Lin <treapking@chromium.org>, Robert Foss <rfoss@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240517021654.1034218-1-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v9] drm/bridge: it6505: This patch fixes hibernate to
 resume no display issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517021654.1034218-1-kuro.chung@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ocxBC3UDqeM5nCY06kslqg/TVkMQrEhNuG0Dw/kVCwd4cxuSw2Q
 UY3HZYeg4IlBOVMNqRCOIb6/Tj75wO5vXhe+IL9ld1VtsU3G7M0uzhgWkrawRN7mNroeE9w
 XJ9WDv2uYT9Eo3XIxssXaBh89q/0hHQDYbMu8BWLEJJXRtTFJXq9wWtX/koY8zbr59j/DC4
 abhIH/nm+k+2HmFBA/jTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o4IVAo/uwds=;mnSJRXK9U0TVbhq8uY4qds84468
 73aA5R3mQSqaP/LbaXvzB6ckDIb7fFooJF8MAOvJdnQpBtTFgd9uvG47fvqB0haSaHacKrhYV
 3peY/dB9TqB1ai1JxsYdTpn/cQzhd6yv0XnaQjCOoaFVHqz7IdR6FqlMidrJN17p5XzKJ24Tv
 vlUjKSp0mF54hG+uNziQDZtf4IwF5+redH18RN6YeFziGyEzvD2leU4CgwAbP+KjiihAIBZEB
 il/FYQNrSx4cqHD+YAp7uXznYbvI2ks0S/0pyMKmgUd9fCh6iHb5r24rKXZ3OlMbIbI6hIGBG
 miuVPsHVgCLHGrgUQ41YooKucFpp4JfDwCudBCWToRM0wlMeJb8coWa/v/OfJMUZaHl0Sr0Dq
 1gq7OZkxRZgjWY/HEIwcyg6ecBBhc3VkzlgaRwbdAXwvObXZLNP6mj8iwkKkrkty6FqmGIS8x
 gMWP6/upxUJarf5FNWdtBfQlbkMS4iv3d7otkdkVkGrIUoyqK6JpUyaeEyKAbL6fdFbOGCa0g
 BVTHTjF8qROAzTmqZs7mqHVJUDzwaLzzu+kd1gJS/qDh6PX5cD60gYF4BiOANFm300xEDRNim
 SssePW/vAB0gJFfTxDDlf7efipUK+nXxL041ZBTTgt9b0tdHFL2S3KkwNicklEbFk28AqpR1w
 ZeIOysJRmWzrLou5F2IaBvWrN00kCpDketEr4pYxQoezHUcFHSmIvjQSHVIQ6AZg+yCW6LFut
 3PIxUFnqICRUkHQaJCujjpjySnEWqTLX7hRt2+DK2N76wWV26BEQA2JfS83/htFdPXhJF6OTh
 XJClDAodXuY+V4lKy5XT8ax96Xm18S3zM4P4fIGGuQkEw=

Please omit the word combination =E2=80=9CThis patch=E2=80=9D from the sum=
mary phrase.


=E2=80=A6
> But the input FIFO reset will also trigger error interrupts of output
> module rising.Thus, it6505 have to wait a period can clear those
> expected error interrupts caused by manual hardware reset in one
> interrupt handler calling to avoid interrupt looping.

Please improve this change description another bit.


=E2=80=A6
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
=E2=80=A6

You may present version descriptions behind the marker line.

Regards,
Markus

