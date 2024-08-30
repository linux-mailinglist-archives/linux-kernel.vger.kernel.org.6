Return-Path: <linux-kernel+bounces-308250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5F965953
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063321F22D56
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE66166F0A;
	Fri, 30 Aug 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrnTGwqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F9165EEB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004977; cv=none; b=W91BJlkDIqoFAaU0NLsU3Ho6jcke0S9HBVe8eam28z2bUwqLijW5gPAJgVNrHT841f4PXV84QhKXlQPxsF0ptIcndIClTH0fxSmxffRnaPV3Kkx7duFJDIqrxiuX1PJTvPmBM7wwS43Kf2t92o6+0ZuHoyNh6sb21hS8ydntKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004977; c=relaxed/simple;
	bh=Tn7vpActXBFlKNA++PpCWkykITcd2eGhlYPaXa642xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EKPjeTwZcvRTYKy2rKZ6hVdWGr70mSunEqVfPK2/XnY5aFzfzR8jHhbl2SsGyuIgBdhHFX5daaR5WuDq4JH+UfWwbZzyN1CUWjcnGO75PI16lOmfnx6EZmOJuBYE9qPKCJFV2a6Ksq9jkZ5bUOgsCmISQAfEv58U/7tOkL4+e7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrnTGwqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81649C4CEC2;
	Fri, 30 Aug 2024 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725004977;
	bh=Tn7vpActXBFlKNA++PpCWkykITcd2eGhlYPaXa642xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TrnTGwqK0FDYspiqzoR1Hf+hbTK4ep/JJ+L3zwuFft0OvmBWQF+lgtnyf75buCR9o
	 MApQ75wI6Z4Fqc2ewr5C9URROIXf6oc75VPDeOTo3fxEw+liLCnLbsUefjoeEA6Gtn
	 lYQi8LXwVFvGDENnBTk8PbALyOtRyZQE/j3fvpKy6fAuq106GFw8qW3QXLbbnaDBiC
	 pIEjvpJs/z9Ms8H72xkYLXDo8j1/aRhRj0BNiFWxEzlxWX4hiagD3Kwha1DQPX+/9I
	 LQcLgHlHtwNPW2zTH4TDK03LFizDXxWduU37B1Jp+kfo/lHOzrzAMDSMW76zjP4CpF
	 eUFHNcnftHLKA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240826191300.1410222-1-robh@kernel.org>
References: <20240826191300.1410222-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] mfd: tc3589x: Drop vendorless compatible
 string from match table
Message-Id: <172500497627.74520.10404767041279534351.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 09:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 26 Aug 2024 14:13:00 -0500, Rob Herring (Arm) wrote:
> There's no need to list "tc3589x" in the DT match table. The I2C core
> will strip any vendor prefix and match against the i2c_device_id table
> which has an "tc3589x" entry.
> 
> Probably "tc3589x" and TC3589X_UNKNOWN could be removed altogether.
> Use of that compatible was only on some STE platforms and was dropped
> in 2013. There were ABI breaks in 2014 claiming no DTs in the wild. See
> commit 1637d480f873 ("pinctrl: nomadik: force-convert to generic config
> bindings").
> 
> [...]

Applied, thanks!

[1/1] mfd: tc3589x: Drop vendorless compatible string from match table
      commit: 6fa9be093a2c1238531a9127db765555a49796e5

--
Lee Jones [李琼斯]


