Return-Path: <linux-kernel+bounces-195225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EF8D4936
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6921F23020
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB23176AAE;
	Thu, 30 May 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FVVMBItQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFB6F2E6;
	Thu, 30 May 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063423; cv=none; b=Gq9Rm5MEFy8bKCdBdGjvwY+vrrXVS31tUMARK6nWYd5BNhJel53j+rb9XMDRHYCIH8n2qRy5BSMAOW1cO1w/mi8aiPVdnEfgrnZJ6D6NjItRGyOWY+YMgBw8cfLBdZKtt1tw2fKwhGErr3Fg24RrzdeGvow6Ls9KLeypy8kf1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063423; c=relaxed/simple;
	bh=BpUdyerGMQW9Se3tgD7/uJMkpsV4naRte+uiUHQllLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyZa8rwEzpaapzEitVc+L0F7HJOAZQTEL6SNvjiBFZHSVtI1Rz+za6Iz2WS8rQBx1rwjNnNslf9j8ohNE0d9h+Pwd6wnPWx7AvKXXVUW8vRj4Xab8rae0F1UrFF6iskc5kbtIEaISwXdUMAyirq8JFmuu5nxcbZkLtA2QLYPs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FVVMBItQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717063420;
	bh=BpUdyerGMQW9Se3tgD7/uJMkpsV4naRte+uiUHQllLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVVMBItQvMb1UhpUr7ebic/YB6pHY3UA731RCaqXSDX6Ey0J0NFZYVbxAY6iOhZ0E
	 TwtYYvd0kM620CTeGenKPjK67V+BECV0wC+OjkifLFYNkP/6VTTh8ZPxA/oYnHZR9s
	 xp8YGyyPYIcZ4ESwoByZyhKp/MU84+h3f/S6NU1kZFYkqTStMSd6F5yOfOjWAh1THQ
	 rXxGOk9Y9RgZJLcbh2dBkJkT8BpAdxe7acPNTVx93AwW32lWXWl4N0HfYcb5wforfl
	 WW/lPWx80YecqcpyZHlIcPCblugLeGIpKlO4dVgcm6wZXK/FbEYNsUy53jKIQvGKyf
	 cNCubjJ3jpz+Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3EE5C37821AB;
	Thu, 30 May 2024 10:03:39 +0000 (UTC)
Message-ID: <d2118c18-af98-4e3a-8113-1cb519677495@collabora.com>
Date: Thu, 30 May 2024 12:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/imagination: Add compatible string entry for
 Series6XT
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-5-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240530083513.4135052-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
> of the Series6XT, another variation of the Rogue family of GPUs.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



