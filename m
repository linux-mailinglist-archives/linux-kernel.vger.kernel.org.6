Return-Path: <linux-kernel+bounces-357143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E8996C60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77021F2385B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F51990C8;
	Wed,  9 Oct 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOi+anq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF713197543
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481185; cv=none; b=Hxt+XCGhm3/MYZ5kf4MekBkvOpaRnZPMdPgg4cG2OopzAj+8usHFccE4Ky2b0P9J7l79iUrx+NiKEvHpQQdYolH31uzUBjIM0dVfCh01nGo3mNzs9tBFCKj+hGGTCA2DR7mSzT/9NQWrrNxsgGuAppHYtJ0XnVfg1Uni0ZashHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481185; c=relaxed/simple;
	bh=DVAYQV2l7t/kEyyE6gsFK/DLgw9b87/2RMip9Tms1ZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jU76MOrdYbyhRJMDoF80o8kFvgMSoqrQgs/rSQR4acejHQfYytry6RdAPV00FzQampw099g1U366U2FH8BForAM9mUayIJTXcM1kBckswemzuWxVfI/KIThCe8GRbZQz6DJYJ48nf2rCSE1FJ4n+TI8aDBcw+dtWgLeEvPzc6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOi+anq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF8CC4CEC5;
	Wed,  9 Oct 2024 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728481185;
	bh=DVAYQV2l7t/kEyyE6gsFK/DLgw9b87/2RMip9Tms1ZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QOi+anq3MS5q4KHEPKLLobH+vAIkD2PogE0cTArgn5mSW09qxEkIgZshV9n6Xc4hD
	 PytF/D2WtH8k7S25BrHu5hYi+L8ozAK0aaEBXov9vuLJ4P/JoS9+WjzMX+GgcUGtBF
	 +njpBr3dCtAaV5Kjz/nv2+IZRZO1jbT7kSdeWxyYRxZKygG4P8ppkWarW/wnDPOjp2
	 7qIohX4eHddzlR5fg0h93fvLQx7UFkPkoYbUdSGorCj60zzpJmScEfR9aJ5l6djbJO
	 Z0c154tT8U0LIIJzrOnORYQGyjUQwljWCuFayty1RFDQvzB1zdH4lk8nNifGsmv/JD
	 /U2nwjGQpLK8Q==
From: Lee Jones <lee@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-1-125d9228d751@gmail.com>
References: <20240617-starqltechn_integration_upstream-v5-1-125d9228d751@gmail.com>
Subject: Re: (subset) [PATCH v5] mfd: max77693: remove unused declarations
Message-Id: <172848118396.551973.17169778525826659736.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 14:39:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 26 Sep 2024 13:28:10 +0300, Dzmitry Sankouski wrote:
> Remove `enum max77693_irq_source` declaration because unused.
> 
> 

Applied, thanks!

[1/1] mfd: max77693: remove unused declarations
      commit: 9a37d57d4c4e55835fdca858ccd3130a0ebded9c

--
Lee Jones [李琼斯]


