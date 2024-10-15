Return-Path: <linux-kernel+bounces-366573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF899F740
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B408284566
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD9189B8A;
	Tue, 15 Oct 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKDdWx8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04191F80A1;
	Tue, 15 Oct 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020392; cv=none; b=GrDlx0n4WHLB3/TRUN6joqyzY/E9zCq8BCLr/NMpHBd2cFvCfB/94cBcPo1bvb9mD1FWiGyP2tQkIfDD5bAr8u0OOtQhOkmr91gZ3F/Eso40FBKNFLlpdnrtoXpmvIoAprqvt1wup8f/mBLCmRUQrpbZrdKn59DJQmDynmvA+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020392; c=relaxed/simple;
	bh=RCm4pxa5IwSPQr+kRJ7ZG2XMJgL6YqyYvgj/rZlIuOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nmp6lcOLBXr+Y9KfL0VBQUElMEnjwqmJyXZNhZdf+zNiz0bWYx8m1RYqgB1MQKw8ubvbclnCQatJw2LzG7VfadLev/PQ3LlhXaeh7BfT/sImASA2y4XByiZ8BrwSxa2HUKVX9IsVLhLvJLeCc2jCJ8O6LIa0S0WFbZpKCRjQK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKDdWx8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04363C4CEC6;
	Tue, 15 Oct 2024 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729020392;
	bh=RCm4pxa5IwSPQr+kRJ7ZG2XMJgL6YqyYvgj/rZlIuOQ=;
	h=Date:From:To:Cc:Subject:From;
	b=LKDdWx8L3S+oU3ss+NUqXW5ItEquHG+YIGBroL5qNc9Z9x4/1IIyBeowfe0mk4z6k
	 lqbZJMTJJ/UvsoCns4udPfIE9hVkGWxmZw3KBq9GNxSvpTWXPKLgFZTt+J4+1Nj6zG
	 uW98Z38xpvRZ+KW9jNBYHX5XwOYp1PfuJxPb6HTeQoHhCmyhd4GgiTe65rLuM1wIoB
	 u8nPxO3TMp75pqmq/fD65J4jrdWa9DWvgM1o0c6O1M/EDNHp5Vq2S2bSv9gXbE/utf
	 9zBSBPXBgw4Pa764WaVa4AYx3mn4ehW4b1VV5F6kXh4jcMS9wkQFMQPPE48RUlAUdy
	 RReXS3K3ahrDQ==
Date: Tue, 15 Oct 2024 12:26:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.2 uploaded
Message-ID: <20241015192630.GA1410876@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

