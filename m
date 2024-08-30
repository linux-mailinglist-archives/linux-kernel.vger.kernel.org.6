Return-Path: <linux-kernel+bounces-308789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8289661D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69D5B28BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CAA199FB7;
	Fri, 30 Aug 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyVkyWb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD312F59C;
	Fri, 30 Aug 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021199; cv=none; b=uujqJOzd3VPCeZw/QSUlorXkZmPesfTTvVjsBCunYIHHE/TUBCfSsV9RuWfchavpDsk2GCFmvrIb0iPONmumqc30lPwJUqFvkBjaAOpI7mw9YTFM+cNIXhZNYvWdum3WlgqBJKix2ppnzKBI72OgH2mrNWdbkjBo8x5El7JCphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021199; c=relaxed/simple;
	bh=4e1kkLC2cNy76ieaQd3T4nEl/kPvRvCtCwI78CJppNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABnbCO+IX3nFmCqrwm0WGTFQeplrFE/CJNWQxLTulGT193O2FgCSl+UNZ2IU3N2bzVYtJSg/3B3M7K8v9FnBynmPSTzKbZlTXvR61Jookgr6G4spGnL97eS/tLKeBwpmooyxxB6yY6uISgS+vI1vzV7rI0yNUOsC2AvshqikNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyVkyWb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D46C4CEC2;
	Fri, 30 Aug 2024 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725021199;
	bh=4e1kkLC2cNy76ieaQd3T4nEl/kPvRvCtCwI78CJppNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DyVkyWb+2R6W5cH+q9RVz3c/TeDJQB8QeM8w3VhdzLK0gTIHXFgTWevEXUxsdTzqi
	 5eD24D/sseeBkZiRgGxcNuBo0AxHbF8j7h1rwDiHUrj3yNUWrazImW4em22r/a63Lo
	 dAESUWctA6okDIUl/ZHkgCllBdkrAy8dmJ4sriy/BLLeKCWIAjTJNb+z/uLBFzrFmt
	 tXTUqGW7YkcNAA96rqRDBru2L09mNG2LLkxombQ0f9DkNbifYQIOl88p7VfeRAMKFs
	 bHXZ1V8oZVFWOkqRPQIkFO9gj++o8GlNNu1mmEAHyyjjQ7M74gc5lHnxKETT3Nl/0j
	 p6VIbvhBIziuw==
Message-ID: <7a02001f-98f8-4c44-93b6-83e167e54428@kernel.org>
Date: Fri, 30 Aug 2024 15:33:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Robert Nelson <robertcnelson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Jared McArthur <j-mcarthur@ti.com>, Andrei Aldea <a-aldea@ti.com>,
 Jason Kridner <jkridner@beagleboard.org>,
 Deepak Khatri <lorforlinux@beagleboard.org>,
 Drew Fustini <drew@beagleboard.org>
References: <20240829213929.48540-1-robertcnelson@gmail.com>
 <20240829213929.48540-2-robertcnelson@gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240829213929.48540-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 00:39, Robert Nelson wrote:
> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM67A,
> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> cores for low-power, low-latency GPIO control.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Jai Luthra <j-luthra@ti.com>
> CC: Roger Quadros <rogerq@kernel.org>
> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Andrei Aldea <a-aldea@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

