Return-Path: <linux-kernel+bounces-421546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5AB9D8CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9032B2D1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9F1BD519;
	Mon, 25 Nov 2024 19:13:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF01B6D1E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561982; cv=none; b=iEKQmiXGULuDZ5Au6XYQXlxLTDyY1+mSHBThUgt3fXKM8BW7cZrtK4/9ZJnBA+IM+bC1tBuURlU0WEOwkxe793+hjJ+tinSfMENtXI7K1F8BNFZZFV3CMLiPw/65DRJRXiGuG4GgLUn7ZrziLJI9CaWOszmfJEmozBVTLq3nOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561982; c=relaxed/simple;
	bh=IOby0VbDqP9htuHNBuiA+4dkYU1BWtgYtt55m/pt2fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji+jXmeoin9o05MBvPtnDCdFHl9jeK0We6Xk5iS2SRivPzXgaKUlipd9aTZTAKk1uI4jNBraR8uVyNHeLk/gyCpu4I4saX3UOb1AZfOPOeHhnkSPr7J1IJq9JY66N1EPrJ8RCt8Af28W+UzODxXp+M5DQiNjVNMlsYFxo9awdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E31C4CECE;
	Mon, 25 Nov 2024 19:13:00 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Ensure port and device id bits are set properly
Date: Mon, 25 Nov 2024 19:12:58 +0000
Message-Id: <173256196647.1188888.6538951137157343141.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121001334.331334-1-namhyung@kernel.org>
References: <20241121001334.331334-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 16:13:34 -0800, Namhyung Kim wrote:
> The portid_bits and deviceid_bits were set only for XP type nodes in
> the arm_cmn_discover() and it confused other nodes to find XP nodes.
> Copy the both bits from the XP nodes directly when it sets up a new
> node.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Ensure port and device id bits are set properly
      https://git.kernel.org/arm64/c/dfdf714fed55

-- 
Catalin


