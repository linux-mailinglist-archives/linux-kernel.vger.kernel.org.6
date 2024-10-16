Return-Path: <linux-kernel+bounces-368433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6779A0FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D3288053
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F135E210C38;
	Wed, 16 Oct 2024 16:30:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955C1714BD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096249; cv=none; b=EM/jBPIUhSaHzJuOZUoQm1A+oqTfhmnpzcYks+KwTKebGOop4qrauIa6wkHxu45JNT8R5sfX50Fy2WG+fOyB21m71iwK2bd3EmDMP4acXN2E8I08B5KousEJoqdrsVwENePqLayFzqIvQHwPe3xafA6LAoAz3wwA4K/QpOK2gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096249; c=relaxed/simple;
	bh=lYElYRFS2rDGFf0dDDojxO5ebYviRYINloGUHHrhgLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu2vJemijtiLMrfk8Zg0Mh5AnUMbeBtPrM520RQy3aB1gf2Wi2H+Q7oqPo4zf0OfXKsQX+jcMNtaEV0HoBApOxx2bwO35sIvHzICNiUEaeZ1O97h3M0qBu6pX8G2DM5INTayFCbgh8YnmDYYUD8bW44kOiFLy0scqCJRrfOE0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3446C4CEC5;
	Wed, 16 Oct 2024 16:30:47 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	anshuman.khandual@arm.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: head: Drop SWAPPER_TABLE_SHIFT
Date: Wed, 16 Oct 2024 17:30:45 +0100
Message-Id: <172909623125.3163685.8468137355196920156.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241014030341.995806-1-gshan@redhat.com>
References: <20241014030341.995806-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Oct 2024 13:03:41 +1000, Gavin Shan wrote:
> There is no users of SWAPPER_TABLE_SHIFT after commit 84b04d3e6bdb
> ("arm64: kernel: Create initial ID map from C code"). Just drop it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: head: Drop SWAPPER_TABLE_SHIFT
      https://git.kernel.org/arm64/c/0f612c6eb13a

-- 
Catalin


