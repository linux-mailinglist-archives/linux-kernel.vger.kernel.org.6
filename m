Return-Path: <linux-kernel+bounces-317608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3304696E0FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0E3B21D46
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3ED1A08AB;
	Thu,  5 Sep 2024 17:19:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADB45005
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556765; cv=none; b=fMHQeh/d+fYtI4ecHXXmiLp1XFyGJOu7LLA6LFN2poyJ7vSrbdOKszWjtVgVH1F9zJzOmIpUIak61sgIxHI8eqcOtaPn843QnCGZDgnCS+lZAub2Z/+o76AGx1CaNDA4QobJzpOrl1rjW0kCN5veEXzVV1MmsKpleGZHOHdv+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556765; c=relaxed/simple;
	bh=ufswrCaKVmDnJCxuyQPoraFo+q7psNaggADoPb1AzIU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/ESU6O4k19+M4SYWGmVVWJ7HT5J0mnebEZD6oxvazktEsPIl9psInZJ7t7Gs7lYRY5tqO2o3A8k3O2XafJ0cgOaNjdCE9P0uESYAgKTRWu4Q0prAYCDERqECNTp2M8fsybBiZP0lHWD8Nq0YDJP8qnD6c05rbt2+Fr0d9pRq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C3C4CEC3;
	Thu,  5 Sep 2024 17:19:23 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()
Date: Thu,  5 Sep 2024 18:19:20 +0100
Message-Id: <172555675029.680759.8903911189573645433.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618162342.28275-1-puranjay@kernel.org>
References: <20240618162342.28275-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 16:23:42 +0000, Puranjay Mohan wrote:
> ftrace_graph_ret_addr() takes an 'idx' integer pointer that is used to
> optimize the stack unwinding process. arm64 currently passes `NULL` for
> this parameter which stops it from utilizing these optimizations.
> 
> Further, the current code for ftrace_graph_ret_addr() will just return
> the passed in return address if it is NULL which will break this usage.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()
      https://git.kernel.org/arm64/c/c060f93253ca

-- 
Catalin


