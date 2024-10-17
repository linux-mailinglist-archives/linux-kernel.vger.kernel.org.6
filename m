Return-Path: <linux-kernel+bounces-370068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650B9A26EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978451C21EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B11DF99E;
	Thu, 17 Oct 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioPyikL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DC1DF98C;
	Thu, 17 Oct 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179354; cv=none; b=M3J3HQpsSZTIFLDyywnEd2r+DQaTiMHwNwh5K4A/ZpJJH9r63EtytlfzrFyBf/X4wBYmrTpOf7nBCZDPXLbUg2lV8rR3ZDTT1Vm/H6MAavgjG9uKTOLaRQ8rm79zBWMuaYtV7/QzJyndk1EbqFn8rzV+aTGV32x9pdrFbSb6DPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179354; c=relaxed/simple;
	bh=tQZtVVyCeRnI9TF1cSK9C2Pyi0D01P9dpdlS4+GOqAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1l7c6/VmIldlbM13VknvNDxy2q5N+f+5CQsXO1YUKjfixCbRQevEOVcJQ+u+DDmkcOL1v6di5m09SMl+IPQ+u4lQglLYnYvOSphXQZB1a5JaAnOb7hlUs5kuFMP+Jq2cMhemqWW7t/RAuoKWa17lKpJMwrgRwJyrVEaAfqJWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioPyikL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94151C4CEC7;
	Thu, 17 Oct 2024 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179354;
	bh=tQZtVVyCeRnI9TF1cSK9C2Pyi0D01P9dpdlS4+GOqAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KioPyikL26+HrMcb/XoQ6mCUhqrcOWg77GM9etxhrPh2M04O1rkbspnA7DAS70dVj
	 Npm2j6Si0m6kkpx0hqk1B+IsYJCBhcJ4FwODFiMeVtQ5IGH4vGvlAOmO4kuo8oxu4i
	 EPPv7t4vtl/Cfav4BuRTcXqsx8f/iq4+YMbXLcOBDPqlTM+qCQ/+yx8iYZIn313RiU
	 fIcmLKWaUrzope7I/b1xg3aZ0Lv5urH5Hyp6KHpGHOXnYk13DPwvSWv/iNyqVJqULk
	 piQH1J6nuBOXmBWpaA8AkQqt+z8IZSJR09qwtFhLQ9GiQfaay9SOUSkdTg/mYeUYbN
	 yk1OKEv0jWgyA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, heiko@sntech.de, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, 
 Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20241014020342.15974-1-frawang.cn@gmail.com>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
Message-Id: <172917935024.288841.18254840723244928611.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Oct 2024 10:03:41 +0800, Frank Wang wrote:
> Add compatible for the USBDP phy in the Rockchip RK3576 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
      commit: b3e804ab9aad465ba7285aa5daf83656d5efc59f
[2/2] phy: rockchip: usbdp: add rk3576 device match data
      commit: a76de028c619dd18f89786805bcc7bb4d379ea9f

Best regards,
-- 
~Vinod



