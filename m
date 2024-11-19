Return-Path: <linux-kernel+bounces-414746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD29D2DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8DDB2CEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EE1D1F79;
	Tue, 19 Nov 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzblwibh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C061D0F5C;
	Tue, 19 Nov 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037765; cv=none; b=UkErY50fy7MvWPsV0R3rYy/XQQfM2CjndgBKLw+zazni+VQI9vJJpIMDMfVvO/7lwDYQi/hd3BReXiYn0JpHxMYuqj9lQ7dYEzjiD0exrGbHzVz3KBwGkNZDM/0d+UVSsVEoqic6LpP5Zhi8lYPkeJ+yP9QKkG3IZc2SbaIr6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037765; c=relaxed/simple;
	bh=7mXFIY79P4EkftJLNh7R7PZZz180CKrz8oYCEBN+4Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy/BO0qx+JkzMzsrOz/a+1sTeKH+Jt/jxsDkCzd0PEAWfeNj4bQ9GOtnpGgYN82Fo4cjfpLenHKAUWJe5ntNyLXAp0p1QNlE8chb5wg1fQz+ChguZzD73g5YSEt5k+lrvfxLttQzYgcrBoruwzYlD+HOzYgtPl/vESH45Y7cpKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzblwibh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC175C4CECF;
	Tue, 19 Nov 2024 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037764;
	bh=7mXFIY79P4EkftJLNh7R7PZZz180CKrz8oYCEBN+4Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jzblwibh7/loTymKSNrM580HiO4f0h65wyajtEwaA5O/jrGPwZJkNNg6kcsKoXLPk
	 MinF7cIuJXhcXH3h2UwAhF+esWmMnzVtdo2z+0AJxfbbLF5pyUsyovwMzau3DOX+IC
	 VExWbxHGkiWNkR8QSan/MP29iGqy+CTnIUzjKmZRr+GcuRwKM/LNB7q77CkGzzShMG
	 2C2FZk0++z6ERLxvO/dwckVELX9mpxsICE0DAnfckbW/+rFkCU4mz2C04Od13mQ6tl
	 kvnSQ//VJslGZVU+9QBHKB5KuBj0h9N+m6dtEH/rm7PfkTPSRTR6byFi0RQ+mag61F
	 J1KgyBhFLDklA==
Date: Tue, 19 Nov 2024 11:36:02 -0600
From: Rob Herring <robh@kernel.org>
To: Bryan Brattlof <bb@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62l: add initial infrastructure
Message-ID: <20241119173602.GA1858974-robh@kernel.org>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-1-4e71e42d781d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-am62lx-v1-1-4e71e42d781d@ti.com>

On Sun, Nov 17, 2024 at 11:34:07PM -0600, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add the initial infrastructure needed for the AM62L. All of which can be
> found in the Technical Reference Manual (TRM) located here:
> 
>     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml |  6 ++

Bindings are supposed to be a separate patch.

>  arch/arm64/boot/dts/ti/Makefile                  |  3 +
>  arch/arm64/boot/dts/ti/k3-am62l-main.dtsi        | 52 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi      | 33 +++++++++
>  arch/arm64/boot/dts/ti/k3-am62l.dtsi             | 89 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62l3.dtsi            | 67 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h              |  2 +
>  7 files changed, 252 insertions(+)

