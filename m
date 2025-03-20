Return-Path: <linux-kernel+bounces-570037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54855A6AB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4331892AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4371E21C187;
	Thu, 20 Mar 2025 16:36:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5191E98FE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488595; cv=none; b=mJYBFPNuYo7DhvC4jzPULnltoZwFIkinroN0e4+WGziid9bHOBNgkZp5XjXtyPtBBZ9OeeMjRaTsvoOLSeusp0M+vfvOnOIQKRn5zhKRWCOa9S+JxMH2vz1GJR32NDTtAAYFVddAU5qKUp3YRxOBQWhaDBZK1MsW/nNLXt2097M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488595; c=relaxed/simple;
	bh=aXaa+cXyctP3FSB8MfE8uh0cGFSGulPbJOoKNGxsw7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjaSQCMK/771WVtqnaxP/tDtxpRpm7Be6zhai5bjOZ3LvLJoBjBofAKpudQhkv2RwTsclXELBLwt4Y5ZWHyqsltqnrQa+iN8seWEMrBe94jt+BYeBfvR3HMoyc4DSikraX5zbUqVS3Mqz55ipTpwgX7fOmcVkIaWEsehHJppRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB2C4CEDD;
	Thu, 20 Mar 2025 16:36:34 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Don't use %pK through printk
Date: Thu, 20 Mar 2025 16:36:31 +0000
Message-Id: <174248858719.1537208.2049891754496228944.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
References: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 08:39:06 +0100, Thomas Weißschuh wrote:
> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
> 
> Use regular pointer formatting instead.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mm: Don't use %pK through printk
      https://git.kernel.org/arm64/c/892d20acf36c

-- 
Catalin


