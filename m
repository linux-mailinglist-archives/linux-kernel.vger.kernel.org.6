Return-Path: <linux-kernel+bounces-428154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C59E0AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E158163A48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CE1DDA37;
	Mon,  2 Dec 2024 18:16:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206F7080E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163394; cv=none; b=MMjVL0fnAdVdHB/jOKDe5VzVSWxu8jf5lf/6NdhGCuDG3oYuY2XOqcQGm3PgGLcK4T3P1G/Fq9LiPX6ocgKVfn6z2WiIFHs4e91KXMiGjVw4g17McWT7/ZAkkMQeCdCPRNR9lMsohFLDq8G38hBR2prVMyImILAddhDT0VqzcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163394; c=relaxed/simple;
	bh=pJP8S4hNYYusRoEumxCc1/OA022W3rfTpwP0WhZs/Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+voxyVjHxp3C0JOiz/jmvC5Fj/K/40w2ZNEVOHAJDUJbUIVJ5k2rq3tOLXvOIfEtEpmuc1zf11SVGOk0bMRfzXZdHHUBei5Zs9Pfe15Pz+CtTD1PyGNL6Xxngo+7rpdMmrdADCXbGaWKKx54n38PiFuhwtw2inbvDb3DIb+6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB14C4CED1;
	Mon,  2 Dec 2024 18:16:32 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Yang Shi <yang@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.13-rc1] arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at correct place
Date: Mon,  2 Dec 2024 18:16:29 +0000
Message-Id: <173316338578.1186434.1700615074381764365.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241119200914.1145249-1-yang@os.amperecomputing.com>
References: <20241119200914.1145249-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 Nov 2024 12:09:14 -0800, Yang Shi wrote:
> The commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") moved vm flags validation before fop->mmap for file
> mappings.  But when commit 25c17c4b55de ("hugetlb: arm64: add mte support")
> was rebased on top of it, the hugetlbfs part was missed.  Mmapping
> hugetlbfs file may not have MAP_HUGETLB set.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at correct place
      https://git.kernel.org/arm64/c/49ccf2c3cafb

-- 
Catalin


