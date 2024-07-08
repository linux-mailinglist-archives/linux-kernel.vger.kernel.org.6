Return-Path: <linux-kernel+bounces-244640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFB92A743
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D44B2141C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72366146D45;
	Mon,  8 Jul 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rXOCARO2"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC28145B3B;
	Mon,  8 Jul 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455892; cv=none; b=owzkGbOhNX566YzswQL21hM3EJRnjs2FgW6r8GSIf8FrYD8pHjE9EVLsk7rdX6WftCytQuXQi4KkJLl440zAOLRPhFtP/s4z9hqAI9Tv5vS8J7OabdHiFiGFnMWgh3gWSc/w8eWYlgW4lu7lCpi0JsFYcqS9LEgxBxrCynQQgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455892; c=relaxed/simple;
	bh=Gp0kHHNFI2rcZtMat8BDy18rJEf5wmNrtHW9mAED3k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCr7X4ISZL2AAuGy7dKFSmZAcieBsSNLefJXkgGr8yyksBL8JZOwP9H1rQ4sVkFWZtbSEq3XqtUPHIcE1styCeIgaki0AGuVKJy9yuVF5zq0r4jT3lKpvgdsvTfBicva7f2JQuIESq6NQ3LGJaHZXSfwY2wpKN8PD/64VFv+GjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rXOCARO2; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5776C887D1;
	Mon,  8 Jul 2024 18:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720455889;
	bh=zUULNVojGptCWtPVxs+eXicSamISZThFxxUZa0HSZpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rXOCARO2PtRFuUu8pxRp+fcq5/BOkRU+FlQqVGeMPDOIc/zZjfqDhHoTh/P7FBx8P
	 yekFiWsXcp/5H1LnmZUcoP1qIU57ow/1LKYu1n4D2s2le7VMpeuaKeV8vlOAlIDs/u
	 Z7QchiKwi9Ozq8kUaKLEVCCcyLaRYnq/cWW/q4kpCkGq0DfugNwPXndMesYV4bL5H2
	 0bSwM5cwCV7rt7PqNkS6czG1S4YoH/PvrmWfHD6V0ghJdkq7P4kNWX+jp+vsDc4ynB
	 IDtxy6elZBhTahjXinTuNdL8Aqshllme4UDXS6Cnsr7fqFpU9VkVoIS/eWzHoM3/73
	 AJrhaXdKl7pTw==
Message-ID: <1921604a-c4c5-440c-9d9b-90169a556062@denx.de>
Date: Mon, 8 Jul 2024 17:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add
 burst-mode-disabled
To: stefano.radaelli21@gmail.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Noah J . Rosa" <noahj.rosa@gmail.com>
References: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/8/24 5:18 PM, stefano.radaelli21@gmail.com wrote:
> From: Stefano Radaelli <stefano.radaelli21@gmail.com>
> 
> It allows to disable Burst video mode

Why would you want to disable burst mode ? This is the energy efficient 
and recommended mode, why disable it ? Details please ?

