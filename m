Return-Path: <linux-kernel+bounces-430139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83F9E2CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517B728A5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FEF205E05;
	Tue,  3 Dec 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="zfNuEh+Y"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD2204F8E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256970; cv=none; b=E0KIKpR/gEDFNriAXXrXSI14v0shC+V8IwRzoW2FqiNLRQU3xEnuxfH9ov+i6uWdJDHV7do1Vbvr98+818cICRusWZ9x/Rct5VAg7PWZYOnYbT0yYl2TN4XU4e1AGuqWqWZE/WgQNYEj0ZdewHsVKfyCf1lCSSumDDGFdlny8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256970; c=relaxed/simple;
	bh=7EazdmpYzyzh8UDYXHdIuwEr5lXQVR8Fa3rVvsytmxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWiQX0gA0bUykl6mHOhP3S7RyTOSHKCoXJIMK/mezcZfd/0a8lE1u7bm/pR/Ieljt0UYGeSCU/fULx1AlhRE31UU7Dl1PNcNhjJZsJzE6YxbLYJiWJT+eqwMugCF881bT7y9Af6hReIcV0LeqjvLX5kfevuwqNx/P/GaBV3NA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=zfNuEh+Y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5603E8939D;
	Tue,  3 Dec 2024 21:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733256966;
	bh=HFPgWtx/TvkI7sUbV4S3AebYBzGL0Om0FylGOBaC01s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zfNuEh+YGm64pqvTE5IVmbBqQHfINNBourjZvZT663OEq7FyAZiJDneSPNUGaT0qS
	 ncK5QiGOEynd24gmprB1IfpzrtbtJbSURmT6Ucr0ka1j6hpi4fBxzswdxc7U5H1ukh
	 XPEKa0oseZw7YL8XDz4LzwozTRg7ftM9o5kq3UCuOEvlHoUZh3dzyYXmHmqyYFmA5W
	 LcmBV4ShDFkiU/RBU+r+VFJvQs4aOsA+gHfQM1Uj6hiRxYRy9/7u874NVPpJ8ONvbi
	 LfVP+CTcaueZwLVe0M6bRuKYXx4WtybumcpWG9PrPxqqXLQTBT4/zqoW+zbJbILPZ5
	 9LqB1gfX9BfAw==
Message-ID: <2d7f8afc-119a-4080-93be-bf3daf017e5e@denx.de>
Date: Tue, 3 Dec 2024 21:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Nikolaus Voss <nv@vosn.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Fabio Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241203191111.47B56F7@mail.steuer-voss.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241203191111.47B56F7@mail.steuer-voss.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/3/24 8:09 PM, Nikolaus Voss wrote:
> LDB clock has to be a fixed multiple of the pixel clock.
> As LDB and pixel clock are derived from different clock sources

Can you please share the content of /sys/kernel/debug/clk/clk_summary ?

LDB and matching LCDIF should use the same PLL on MX8MP , else you might 
really run into odd issues.

