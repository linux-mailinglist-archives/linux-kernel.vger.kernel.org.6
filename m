Return-Path: <linux-kernel+bounces-182886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDFF8C915E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B60E1F21E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6F3EA72;
	Sat, 18 May 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S66wiEfv"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A11F5FA
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716038487; cv=none; b=XRmZ0uNT6u2MEkwML395CvYN9uZOsUeMTapb4uwICYWVC+qFLvUwjarmyeAJD93t8qSIz+71o1XcvxReMOmrjV3Xpazz8dl5OyiHClcNO76xqLxiP9JJYQG5ob3//s/4ypsakl66tzPTXTqOIM6Z4sCg91iixaYE1JiGSCeo8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716038487; c=relaxed/simple;
	bh=u16OiIWEx6HPEvJpf14r5jR3yHhHV19bMmlM9Nj+PzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFFsiNwGRTxAXAjuvbYFjXHzgnYy65fr3canQGsVx7gDfMCOW4XcCdSp1bEoea2gJidJDTlwLp/0h87nDGkNwep1WPkYxSIAtdQzEJOiKPxWgr0eCYsUS+/MXVByZHSAiPDY7zC7ei46urt9y9e0dH6AZeT/eEY57ti4bWRzGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S66wiEfv; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dianders@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716038482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+XZkADxoXZ0DB7eXEnh8J7Qynp6Huw6DX79kn85yPs=;
	b=S66wiEfvqu+Giau5N20Bp+EzLh/9Y40AGsIcGADEZGBt7DQeJIL8QaoHPqIfqUQ9dom6cz
	isvbfaoC4axdfx3QKGAdjkziRQGgihnQqMSOYvsiC/D1FAa/l1sHSZCe1MSenL/M/gC/ZL
	v+HdEJaDAUqD6CfwqKmDRyPiADR+MS4=
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: mripard@kernel.org
X-Envelope-To: linus.walleij@linaro.org
X-Envelope-To: macromorgan@hotmail.com
X-Envelope-To: yuran.pereira@hotmail.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: airlied@gmail.com
X-Envelope-To: quic_jesszhan@quicinc.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: sam@ravnborg.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <d06f2708-9700-4ca9-8d3b-aba5f1765181@linux.dev>
Date: Sat, 18 May 2024 21:20:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFT,v2,26/48] drm/panel: simple: Stop tracking prepared/enabled
To: Douglas Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
References: <20240503143327.RFT.v2.26.I865be97dd393d6ae3c3a3cd1358c95fdbca0fe83@changeid>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240503143327.RFT.v2.26.I865be97dd393d6ae3c3a3cd1358c95fdbca0fe83@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/5/4 05:33, Douglas Anderson wrote:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.


I think you are right, as I see drm_panel already has embed
the 'prepared' and 'enabled' as members, remove them from
the derived structure could probably save memory footprint.
Reducing boilerplate is also a side benefit.


> Signed-off-by: Douglas Anderson <dianders@chromium.org>


Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>


-- 
Best regards,
Sui


