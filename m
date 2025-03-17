Return-Path: <linux-kernel+bounces-563251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02BA63B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04423A6B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883AC13B7A3;
	Mon, 17 Mar 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0zpXIzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2876944E;
	Mon, 17 Mar 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177989; cv=none; b=LxdRT0/pNEQxGqhs8PUvTpoiMbOyUqZuPXfvi/22T6C8/UNkvKTRS27f48kcdIxH7/PehbWqFY5c8k7oY47UobUU/PeE4stuepzdK6G7B6N/m8evQ2CvyJl+3o0dGQmEEDnhV9rerHKTg8vvtlzqinfw0JzwbHEipYBO/lV18d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177989; c=relaxed/simple;
	bh=KmUn9slvYx1bm2Qy4Js2dvCQrzscY78OedCyX7ZC/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/Tv5I+KL5hl/VfjQCU3f2ZmIN1ZSpch9UAN0/XazQqziqJmSLHzF8WX6g/GGo74uep1HdI7cWYeMZpzsR3jfyMRfRAOpAIIxhFmfc93NIO7Yr1g5d3+JH1eCOWrw7HkYkGYVZQgMsK4cyt5lGdmwTAMPGDhr8O02gHWZx46Fdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0zpXIzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF8C4CEDD;
	Mon, 17 Mar 2025 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742177988;
	bh=KmUn9slvYx1bm2Qy4Js2dvCQrzscY78OedCyX7ZC/pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0zpXIzVfXS0fwMbfQdhvZ7wjNd5pO6GEmtlbWtm3hwiN1nLJTg0/9jDs1TrKdzWV
	 pdkILEYLbBCQ2oSMe8OpG/q8jDmj03H365GdSKwDu66TlfGeWc33ANyb6+ZTDO7MKk
	 lOO12Vs6XwpXYl1K6rZrZKN4s16eCPDyXyogyfSbCFT0XENwoNNlob+ky3OcO/kn/9
	 vdvBVfpsreeWTDkPnpSsf4aH3iwJo8ezL+lpkr0UJOeS42vVvFulEa9rIRLEs1p3cq
	 kKbW0BVOyDKlt9G7cf/qVr/2bzMJDnwTiJOGMtNgac0G/FYo8TCkCkEEqHeXUIyA9k
	 LHODOTKedUh1w==
From: alexs@kernel.org
To: si.yanteng@linux.dev,
	jiang.peng9@zte.com.cn
Cc: Alex Shi <alexs@kernel.org>,
	dzm91@hust.edu.cn,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: fix spelling mistake
Date: Mon, 17 Mar 2025 10:19:34 +0800
Message-ID: <174217796189.171.16994921459981327377.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn>
References: <20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>


On Mon, 17 Mar 2025 10:08:11 +0800, jiang.peng9@zte.com.cn wrote:
> The word watermark was misspelled as "watemark".
> 
> 

Applied, thanks!

[1/1] docs/zh_CN: fix spelling mistake
      commit: 26543ba81da682ff7297c0ad038fcf4261e7eaf7

Best regards,
-- 
Alex Shi <alexs@kernel.org>

