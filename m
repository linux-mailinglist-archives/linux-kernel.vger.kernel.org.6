Return-Path: <linux-kernel+bounces-539824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BCA4A966
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9080B166BE8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD6E1CAA60;
	Sat,  1 Mar 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH3rpTBI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B801C68B6;
	Sat,  1 Mar 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812743; cv=none; b=qlDU+XIjIMvopn5qkRvofRXLmqE2eHAGu9X0oWI/5orRBYSwj7mrgBL13ftqq3ECLE9UXxVneDP33JNTmvRbAnfG7PRjMCC5nJcz1cfmjcV89zcIGDI0HskElK8+wFoIw2Nzy9TJe3pOcCmPpHd4NjAuW3pZJDlSd0da+4UoCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812743; c=relaxed/simple;
	bh=yVJt2XxPJkXDsYR5/hz24cQxvPQ9Z4yO07rKfmUMNJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ic2NMJVL2SEdhW1P6DnlGHnscSwn8OE/mMgIODvvkei8+0Uaza7PAFuCRWCUPBpjO4EEAfBgsJsnRhgYcPES0qvpEy2FKSAydSezP8aGiZe0l9vfA39ZwB076AAZE9b4HJH1kSizx0Yww4ORwQVqtlXRPMzeZoeZVCQn9QUfq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH3rpTBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0BFC4CEE2;
	Sat,  1 Mar 2025 07:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740812742;
	bh=yVJt2XxPJkXDsYR5/hz24cQxvPQ9Z4yO07rKfmUMNJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VH3rpTBIKkP/R2U1T2qD724MwzEMKlQXOAG/Gtp+JSs65wiHzAxMvPEe9H8h11/L3
	 tjbZVBTmBXRjkeuBISMbtIQ+FQRQqR64zOxHzVceyn9Nz1aleiLJerMqdz2MCYztK4
	 IGNJijQ0azb4dpAfCznqtYtO96BV3smbxw4dmWgV9Alf0JVnjwSKqwz8Mrp3A3Gdcq
	 N5IKv0Lf1e5FP9pOiyg8kERVuEx3ancrM1PUHbuBsX3yiljSXLy+1YTV4t7ksmKYPd
	 DN4/ZVa6jX7vlENmu9oQWC2M/9isuaLx4kaz92TITLQZ4tdH90L71R8J25qn/9mkJw
	 iwNUNXK+Xmnug==
From: Will Deacon <will@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Date: Sat,  1 Mar 2025 07:05:26 +0000
Message-Id: <174070628228.2931531.10306009057184657839.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 18:03:39 +0000, Vincenzo Frascino wrote:
> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA [1].
> 
> This series adds dts support for the Arm Morello System Development
> Platform.
> 
> [...]

Applied PMU driver change to will (for-next/perf), thanks!

[06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
        https://git.kernel.org/will/c/0424b1a81a42

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

