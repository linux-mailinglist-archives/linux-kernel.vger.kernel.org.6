Return-Path: <linux-kernel+bounces-292402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4712956F07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F87EB26905
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7D13AD2A;
	Mon, 19 Aug 2024 15:40:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0F13210D;
	Mon, 19 Aug 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082059; cv=none; b=N++R49JlkcgQ7A2EhJD4GcPJiNHe6rJMhEVHG4MnknenvZ3XSEod27B0HExK6pKg+ajxaOpKz3udldU1lhMkFas1ymggYkUD5qSOuGr7w1T5zAXwPcsP2MdRmop3rfmIJbK1PbyfdQ2itEpmKjsQhYrlBKL+D57Cmb8HxkGp2Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082059; c=relaxed/simple;
	bh=crT4E+ZF4JxqOte7JBkkPvImKh316aVnEZvH53J1DxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5B+fm5ufIX49D7A1vhlqOHAmQpI3wLajkTriSgCRHOrCBMcpRYhdgXIOdjKcn8pyPBzae8Sz+d5q9wXenG1OiXClhZHkOG/22ZpnCG7PBIV15QluUXT2EFdl6DyyV7BDAR/RxoSJ/JXeckKoA5dE3NArmrq/Q77yZHP3zQYIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E246339;
	Mon, 19 Aug 2024 08:41:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B2E03F66E;
	Mon, 19 Aug 2024 08:40:54 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	Jie Gan <quic_jiegan@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Jinlong Mao <quic_jinlmao@quicinc.com>,
	Song Chai <quic_songchai@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH v2 RESEND] Coresight: Set correct cs_mode for TPDM to fix disable issue
Date: Mon, 19 Aug 2024 16:40:41 +0100
Message-Id: <172408201689.254020.18396462243018202871.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812043043.2890694-1-quic_jiegan@quicinc.com>
References: <20240812043043.2890694-1-quic_jiegan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 12:30:43 +0800, Jie Gan wrote:
> The coresight_disable_source_sysfs function should verify the
> mode of the coresight device before disabling the source.
> 
> However, the mode for the TPDM device is always set to
> CS_MODE_DISABLED, resulting in the check consistently failing.
> As a result, TPDM cannot be properly disabled.
> 
> [...]

Applied, thanks!

[1/1] Coresight: Set correct cs_mode for TPDM to fix disable issue
      https://git.kernel.org/coresight/c/14f5fa9b5fcbe2b3d5098893aba6ad62254d2ef6

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

