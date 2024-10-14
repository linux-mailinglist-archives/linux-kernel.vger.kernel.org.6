Return-Path: <linux-kernel+bounces-364457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CA99D4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC51C223D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048791B85D2;
	Mon, 14 Oct 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFmKGHJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E591ABEC1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924181; cv=none; b=bNLUn3jFaAyBQ61JVtaloGa8WyHPoijC7SxJACPjzv3VKqeQ3Y/+jLSB/8Od3IEnXhColqFnggqKyLqXjpGOHb6crt1x9AmQtuAgd2pKbEMOjjWPzrPqu2g+PvcDDOegIBqzp9csmeP0RFLgsGxWkWawvlOoSigr7uQjQDt/WqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924181; c=relaxed/simple;
	bh=mhuTLS8rkJN1APjpHFdD9tZx5pr1Rtt68aavLelUrrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STKUKqalFd00AVUMf4HxkOvdQPK/bPdOTkijB9K+haUkHbR/VjBn9PlhAL4WjKY6pS8wqj//Hi4RTODEX58FsgArrhFaZyY28GNMCvTcQZRTcvw/6GlUAijyCQFqIcB4YA0qx48E0881ANFLuhhBK3ouFzpva2/aOnAICBR1Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFmKGHJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA956C4CEC3;
	Mon, 14 Oct 2024 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924181;
	bh=mhuTLS8rkJN1APjpHFdD9tZx5pr1Rtt68aavLelUrrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFmKGHJZaVuEoUZO7kT5IjtXvEsg5OENO4WzhIVTzVznYzuic4wsq1+51T/QoRqow
	 j4NaBs0LQMmKpaXEWumaFlfcnsne7nEyxtEpzmx3SagYzlZ22IROQ7aN64ygtbzwXW
	 qXqnapPmJJ7ti99yvny2MT2ABmJOiF7LsYN7nl2weh0sz4ndXEx5D0KW1DKYJVxGi4
	 0jmidkXbp1SFeNC3lXA9WAhxJQQdF3u9HPkfvqP71YL3YrP17WBYcBIrmdqOruw5MY
	 6Ml4ClQIHj2ign0Kv6A33SWZu4HM8ZDR6rC/LoZVxQBe498LD9cclQCUkER5AcTuDE
	 1tnKmsf/Ie7rA==
From: Will Deacon <will@kernel.org>
To: punit.agrawal@bytedance.com,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yunhui Cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] drivers perf: remove unused field pmu_node
Date: Mon, 14 Oct 2024 17:42:52 +0100
Message-Id: <172891321413.3524788.1805457715906555275.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240919034601.2453-1-cuiyunhui@bytedance.com>
References: <20240919034601.2453-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 11:46:01 +0800, Yunhui Cui wrote:
> The driver does not use the pmu_node field, so remove it.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers perf: remove unused field pmu_node
      https://git.kernel.org/will/c/cc8476789983

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

