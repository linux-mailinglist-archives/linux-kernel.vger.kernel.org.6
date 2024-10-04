Return-Path: <linux-kernel+bounces-350260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5F990272
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CA1281C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35A161902;
	Fri,  4 Oct 2024 11:47:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE41D5AD8;
	Fri,  4 Oct 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042446; cv=none; b=I9C9jlqqfUNI8Ti1o/Ot88k5Wn4vghM749UpT5VUtC+NmeY9NZ2M+eI/Q605dE1+5sPMCaeJgiEefZuJ8gl3FCGneNic1HkWFC8khaxDK23uFibcaPslTx9rKttmWJq8Nkv4wdOKBED6HxwQ7yqaX+KLIy5V2vFxKcUNmqnoxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042446; c=relaxed/simple;
	bh=0SLIkc6pXbim1GsR1XPmtqI24YJ6z9f6qFd1qlGEDxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kl3usqkv4r5amzmlRZ75oIXjKxj6QibjSlhZ0x2c/vYpl8uAasnOs+9LNUQHqb7DcJtHnlklLts3quiwK2ROUqzEUc9/w4GYrnXjaD+Czt5DTAYLRUKXwurtfuKm0wsh7YcH+7DtB3lBh4t9Ctw4/6O2XOgKR4RcLExhIbO/5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79203C4CEC6;
	Fri,  4 Oct 2024 11:47:23 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Rob Herring <robh@kernel.org>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: James More <james.morse@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386
Date: Fri,  4 Oct 2024 12:47:21 +0100
Message-Id: <172804243078.2676985.11423830386246877637.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241003225239.321774-1-eahariha@linux.microsoft.com>
References: <20241003225239.321774-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 03 Oct 2024 22:52:35 +0000, Easwar Hariharan wrote:
> Add the Microsoft Azure Cobalt 100 CPU to the list of CPUs suffering
> from erratum 3194386 added in commit 75b3c43eab59 ("arm64: errata:
> Expand speculative SSBS workaround")
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386
      https://git.kernel.org/arm64/c/3eddb108abe3

-- 
Catalin


