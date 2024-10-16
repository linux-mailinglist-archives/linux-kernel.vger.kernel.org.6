Return-Path: <linux-kernel+bounces-368431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27179A0FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21E51C22D60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612A20FAAB;
	Wed, 16 Oct 2024 16:30:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289D187877
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096240; cv=none; b=FctOhe5R+1uVS2Jfqrg/87zVGiktm1YDpCjv6l3bLnIQMEX6W5Ua8jdVX5rwt2sjEM/OTE2WooMbfAwSR5e7M+ilexZ6AuXYSVeTNZwOizsCmcdGXjL5gbLuno/+1qsrLsvXsTMzcR6+aI70B6SiNySWGSio7gRia18x1seYmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096240; c=relaxed/simple;
	bh=g0DQXNRWLrfbiFdwevDNe9hojE/VmR4mFgWxQJ0j3yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M05ssTliUsf1TfimGOD+n8RAD+F0QR6UU/O6oEZPiUHg1FlmE9SA5tyLdW8/gX428S+3jZdGtjJXA+1MNcN1od+4PNdHZ3kOUeEW9ikhadJmFajQqzlTjb6tHzusjy3BdwcJqlK3ldWGCq37W5Dq+UFmCIvP456QA5HydeKYNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B67BC4CEC5;
	Wed, 16 Oct 2024 16:30:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] arm64/mm: Change pgattr_change_is_safe() arguments as pteval_t
Date: Wed, 16 Oct 2024 17:30:36 +0100
Message-Id: <172909623125.3163685.2221495929826054136.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001045804.1119881-1-anshuman.khandual@arm.com>
References: <20241001045804.1119881-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 10:28:04 +0530, Anshuman Khandual wrote:
> pgattr_change_is_safe() processes two distinct page table entries that just
> happen to be 64 bits for all levels. This changes both arguments to reflect
> the actual data type being processed in the function.
> 
> This change is important when moving to FEAT_D128 based 128 bit page tables
> because it makes it simple to change the entry size in one place.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Change pgattr_change_is_safe() arguments as pteval_t
      https://git.kernel.org/arm64/c/8ef41786d88f

-- 
Catalin


