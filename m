Return-Path: <linux-kernel+bounces-236261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89991DF9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B72829E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B165158DC6;
	Mon,  1 Jul 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbVfdx4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA7158A2D;
	Mon,  1 Jul 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837719; cv=none; b=JRA3ChrhkMlvR7sOf2C9mzo1zbIYHlD3ktRYACrHwmdQZqRMZTv/ZtMFo4D5ep1f4B2NwGjeSmbPvkaXPY5Wc7RSYmPW1i/bw1+z5HvzCGyCxm1V5wQtKzX4+IRQoQ/Ht/7Ju/5uSTnzdh1WhoDloSKbQM9LEXEpenfKMOtmiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837719; c=relaxed/simple;
	bh=NimlwR4Kzo7z3E/7FNBocqLKUoUcjTXVE/3ZG/RnIHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZIkD9wrIrwB+m+D9KWxxP+HpkvpL4fjkm1syQEOfp3oxq1O9fFdffaTq1/aMQ4J36ZuYQLcrgIlKkbusg9cmhHeQvbGejr4f59CSSYaPbp31vWZNAfBG98M1xrgY6BbJbTwo58duwieY369wj4NZxYUPkqq5tZFZpnA7cNqgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbVfdx4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A33FC116B1;
	Mon,  1 Jul 2024 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837719;
	bh=NimlwR4Kzo7z3E/7FNBocqLKUoUcjTXVE/3ZG/RnIHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KbVfdx4p5Tdu74xIWj5ifnmRZx5PH3FWm/4vYnjch6Gy5PJ0lhKI4/UclXgbylbRI
	 ScT1ePiWkvZB/+0o3t3O7P8BFt+X9JQJzNbVlVW0SbozZmQd2hNMGa8wT4KgvXDskN
	 IV36dua7gtiznomyUaF3E2gfhFT9eGLLn2az5wPkcLHaXAGsHoQwjTJTPjIT9dFMH0
	 8T9ipT63Olqg9KKHp/kYyTnYMJlhk3OcimdwbHfHUeZ6VuzQ6Xy8bNExVK9CALNmcR
	 QP6ESYRSceFvE6J+6SOOT42EjEY4RCMHmGB76wDKSuGrkyI0OQBJ3/Zan4KhTPt2xH
	 ip0LHSytXKbGw==
Message-ID: <d9efc055-523c-4afe-8945-7bfc1ddbb481@kernel.org>
Date: Mon, 1 Jul 2024 15:41:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH 2/2] arm64: dts: ti: k3-am62x-sk-common: Fix
 graph_child_address warns
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>,
 Tero Kristo <kristo@kernel.org>
References: <20240626101520.1782320-1-d-gole@ti.com>
 <20240626101520.1782320-3-d-gole@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240626101520.1782320-3-d-gole@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/06/2024 13:15, Dhruva Gole wrote:
> Fix the following warnings when compiling dtbs with W=1:
> 
> ../arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:343.10-353.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/tps6598x@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> ../arch/arm64/boot/dts/ti/k3-am62-main.dtsi:633.22-643.5: Warning (graph_child_address): /bus@f0000/dwc3-usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Tested-by: Roger Quadros <rogerq@kernel.org>

