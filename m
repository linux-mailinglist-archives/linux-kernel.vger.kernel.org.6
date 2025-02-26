Return-Path: <linux-kernel+bounces-533981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C334A46112
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA10189AEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376821D3C3;
	Wed, 26 Feb 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plmDPQff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A541C71;
	Wed, 26 Feb 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577253; cv=none; b=ceDRyuBVXbX55MeGCAeT+Wn+VQrsg1DQy/8RB6ESFSBijoRAY7LXP9cI9JCexwSOQt1Wh+sdsZKcStCsvpOk3FN8OokgdzyZbCBCh+/3j/TcsZMwWma2tdPco61/CpueTnHH8Dym1ICm+pJR1+3zOsqAKPmSkvalBGL3fSN3NGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577253; c=relaxed/simple;
	bh=L6uf8oK5Soc9nDM8bA/96inI4Vk9d8hajhh3H5dyhA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqZSyLMaN+EdQxSuMflXNxKqCl4QLA3dtqS/Cvwk37U6MgeKAEi+8MB/XUu+CjhIxOdD0y5xeBy8KFPxD6fvCci6GwJc8p17U0/WNxfejmRQAwXx+bEmWSj8V0xbHa4aww3D1cyWxwrWUUS9kpA+sRrPo9rq4k9sDJleHAIloVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plmDPQff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D8EC4CED6;
	Wed, 26 Feb 2025 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740577252;
	bh=L6uf8oK5Soc9nDM8bA/96inI4Vk9d8hajhh3H5dyhA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plmDPQfffxLBH4hefq4ApcNM4TJVesG1HZV/fP+ogm+ZwC2Yupya4kxTTbreaj1yz
	 kOlToeGuT+ljmA7W9+X+SgUILMCl77us2dowIa3gyvQNTiftYTr4krkzPDwBWdVsOH
	 sooipGquFleq+wvGGNZMVBwdzFiK3VwJs25M0o1Clr+dJ5O+OWioL9P7x9WXqB8uyc
	 37AH6uklzTA+cexv5RdXvqPm0E6PNN90JdQuzFrUY1sHrweIRaBq9GXdHeThUJWx6q
	 aBQ3fpPio8+SnScMs0HYXhPVMiokMBORoc7l2+idJ4od/r48sZhr/DHZFOHsMRjSG3
	 5/VYQAfD0hvfw==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add missing SDCC resets for SDM630/660
Date: Wed, 26 Feb 2025 07:40:43 -0600
Message-ID: <174057724686.237840.12163185412028867634.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203063427.358327-1-alexeymin@postmarketos.org>
References: <20250203063427.358327-1-alexeymin@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Feb 2025 09:34:23 +0300, Alexey Minnekhanov wrote:
> These resets are part of GCC space and were missed during initial
> porting of the platform.
> 
> Changelog:
> 
> v3:
>  * dropped fixes tags, picked r-b
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sdm630: Add missing resets to mmc blocks
      commit: 0e2a500eff87c710f3947926e274fd83d0cabb02

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

