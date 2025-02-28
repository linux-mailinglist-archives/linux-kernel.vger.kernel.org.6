Return-Path: <linux-kernel+bounces-539567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B0A4A5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87BB17711B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B851DF258;
	Fri, 28 Feb 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5BpPA7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB91DE88A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781501; cv=none; b=j1FGPSQAgqPcRFWTl3/OhWcvPMYuMYF/wrXNlweBJ+XvVHoZGCuw8P/CEU44s+QTb0scww7I5MHrEKjR/TFHX1bQR2Wclvdhd+T2o/+pZxC/If/q8u0ddpgiFE7e+6TeshfKiRbKrnTDp+axx+nKCjMsoCf2QKOZs/3yKCpr+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781501; c=relaxed/simple;
	bh=9ySR4eG/lvsdSBqp/hOgh9krsK9BmeOEtOjROvl8VcM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lk5OKOYsvuE70joY3hAe442aAUcbFosfc+997x5uN67HQ+/G5wD4h9R/63QeBybzuxJv372rGRN/UZc7ieH5wg2bMsn+ESOgEKgVXdqWmhOZVVDxNG7dBWaooHPvqBcCCBTvRuqRvRM0NwnMNRCNj121XW//eoW9HiJBG2EJ80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5BpPA7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE12C4CEE7;
	Fri, 28 Feb 2025 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781501;
	bh=9ySR4eG/lvsdSBqp/hOgh9krsK9BmeOEtOjROvl8VcM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V5BpPA7IDmrTS0R4gU2QoB2fNKd14qwq8nRK8r/3OXaSFzgOhYGOT1DByqZukTqGf
	 lYPp8kikxnXE7tq9z9ApHVBQT2+pktEstjVCssM5xZRel+bN+016fI/Ku41gTYZsZk
	 PxaIHW9sLa9raOEFx+bdamVpaIHLARAzdIi8rifPdqcG4lbfGkjgR++RI9qH0xqCuK
	 dz9tyqaP9u6AjWlcQ4f/phpgFGGEfLP4TXqz647fybe+IDWF+e8zUi/gnGR6n0Eqgb
	 Xh0VERisAwr25Cu3nlvy/mFzczasBTocKNXto07O4MkF0iBV93DDOsA7h7QX44wvjU
	 2jslTCgD6wA3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
In-Reply-To: <20250225193600.90037-1-irogers@google.com>
References: <20250225193600.90037-1-irogers@google.com>
Subject: Re: [PATCH v1] x86/insn: Fix linux/unaligned.h include path
Message-Id: <174078150114.322575.5515178277155013730.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 14:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Feb 2025 11:36:00 -0800, Ian Rogers wrote:
> tools/arch/x86/include/linux doesn't exist but building is working by
> virtue of a -I. Building using bazel this fails. Use angle brackets to
> include unaligned.h so there isn't an invalid relative include.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



