Return-Path: <linux-kernel+bounces-194611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A358D3EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82541F22404
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B74A1C2324;
	Wed, 29 May 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUm/aOHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CA167DA0;
	Wed, 29 May 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010839; cv=none; b=kVxfmnBqFYMJG7HsaeAGQq8w9yLsMQxj2YlkuLz6Jkh/lHklTTYcbBcveSIAxW77tnd5DsBZeFA6lOJz4mbAaDZZvb2qXDnWpBMsNk5a5JTOMQLg0WqAVK/EInvXsaV8psS5ssrDeuLBkXktyjtTCPYzFVhpWSO4BsBTs3ymkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010839; c=relaxed/simple;
	bh=kY+2SCf0hTLDGjGHc9JInsvJkSp5NvfVVE2OayZ5Aes=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyU94RoitfwktwDDs8R9mEVa5BZGfJHYmFtMCeS7Vvlb0yt44D6cPlBhoBya5Jf4Av0iWE5ykNMQCkifsGtwimKpjM90Jd/vWcyB/SB6WKn1a3GS8f7LSI9HaXM4g0pva/JBysRJuuJBNddrlwwUQ3rZLiy6yAVPWEHXR0U4qNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUm/aOHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94930C113CC;
	Wed, 29 May 2024 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717010839;
	bh=kY+2SCf0hTLDGjGHc9JInsvJkSp5NvfVVE2OayZ5Aes=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hUm/aOHn1NJ1GKjC+Mpz/DuBMcoFtsPgPHKJoED0kqsKz8p6hxjYS6ROLudyI3A/h
	 WKZ0sSpdAKpwzSsoNC5droHxykxs9Q2pxEh0YIhbGhkxR5QTNksXJLxc70CEhl709d
	 S4ZDk1iMjweXBrp9iEAC2+vygBGIWU2ohyggqvs5c6OG+2V8j6g3hw/EGyn6TPpFuD
	 hsTPHc//hdExSlfQrTnBwrb2m4wXfPxa7W3N+fGjICk/UEvulZBFL6FtUClpiqTqGk
	 mhL78AoTVnVgKFCfBKjPbFGFkzyzphnNTrddyclUpDCRCQcKRjB9c0tG02n4zfmOaE
	 CvXbe5DUW/x1w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1] perf docs: Fix typos
Date: Wed, 29 May 2024 12:27:17 -0700
Message-ID: <171701062469.353211.10022202446130808492.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240521223555.858859-1-irogers@google.com>
References: <20240521223555.858859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 15:35:55 -0700, Ian Rogers wrote:
> Assorted typo fixes.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

