Return-Path: <linux-kernel+bounces-313184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D696A19B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250EB287FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF1185B55;
	Tue,  3 Sep 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMWA6gD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35618154BE9;
	Tue,  3 Sep 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376021; cv=none; b=e8cupVhRbr9Z8nS0U//eKfzua5dGWVKriQyMAAftr+BG1opz5DdrEpj1KabZW35k6XuIALuVPptkLOibi7CX+6lwP1seaFxsvS+IhEM4kTgI3cgWXLlZU1ZvrH17Sfttx+eavQkgXpxhu/QogXq5xkbbpGMc+lRszq6vlLp3t4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376021; c=relaxed/simple;
	bh=dCX/+ymEEizv2lXNgJZKqJY4+xncuX9LLS1eaiFIiuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=foPUMz3Q86XwPNGV9U6vMWZzTVAX9OoymuzI6VbLwc8JTBtqdtk98TVSETQVcRhj4O0YChGn0yW925DDIwXusN+yfHL8D6XjUl/P/LfK7iX8GFPFO74b5ZVOS9bQjM11e/4TRl0F2kWvqxvxmdlpI2vYeWjfogq+bgxNhODysKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMWA6gD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2AEC4CEC4;
	Tue,  3 Sep 2024 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376020;
	bh=dCX/+ymEEizv2lXNgJZKqJY4+xncuX9LLS1eaiFIiuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kMWA6gD9+MGiN8c+7bAolZdVxIkbf9Zg+/o0aG8H08AVGirxihv2GdoqubplHQQZl
	 lepfH4RjnA0s/FOOknmljqot7SwTTAflzQCYvkcairG9rEIlamrasYy4Vy3wTl9IlF
	 TiQQplvJ8IUJzmri/7mQQXQ2/gCt1UjVXb0GeTGklE9fXYEOPvYZ9GPzsObogTRX41
	 xIYeFAZScvnkxTiCi7KFpBAFdsKLeui36Xj57leNLCGN/+jS6ym2MEM2IEJKb9OZoY
	 AwL63FfqLsn1bEizByvDdo6r1QMhFclBsaSK+7KaSHD0vjxDGbDzCmtp8Rk18pqFis
	 9JMTSAqpJd7CA==
From: Lee Jones <lee@kernel.org>
To: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
 konradybcio@kernel.org, andersson@kernel.org, lee@kernel.org, 
 Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240830133908.2246139-1-quic_mojha@quicinc.com>
References: <20240830133908.2246139-1-quic_mojha@quicinc.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: qcom,tcsr: Add
 compatible for sa8775p
Message-Id: <172537601848.1262771.2330175079813010884.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 16:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 30 Aug 2024 19:09:07 +0530, Mukesh Ojha wrote:
> Document the compatible for sa8775p SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mfd: qcom,tcsr: Add compatible for sa8775p
      commit: 9a9f2a66f8d1362f1217b33bfb1f702b5ef3a2e4

--
Lee Jones [李琼斯]


