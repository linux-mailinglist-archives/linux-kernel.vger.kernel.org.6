Return-Path: <linux-kernel+bounces-223963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC407911B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA9282030
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA716D4DA;
	Fri, 21 Jun 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1MGzifU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C0145B0C;
	Fri, 21 Jun 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950303; cv=none; b=CFIFKrEe5R9OP579O2lY27XhdxfgKg8KpR/FhRnHiLqWEy5JZ+iTWms9hLAjUi1fH6aYpVu29V/16MYM9F5E1c7oZMTuSgBQL3qm82EYaVnYi/EbrRxPI34I9Cjh3PfmHzhrTGPqqQdEYVqggFjxv33a8zEaMYiX999RhJiP5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950303; c=relaxed/simple;
	bh=Rt3SceI+3WtSlghMCrF4xk0O9VqqF+9ICLfLpATWNzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im+AAMZoipJpiXyJHHGzaIyF3DrX8BJA6PZKdo7w6PafB5mdwX3Dm8CX1QVREbFDTyP9aRfq5k1aIWiAeX6UyydkX7Th1eMM+Q1zap4MtgTPuRNbzw0mc8YN9FXo/zcd3HPkCPsZLYcCruEAVQG0K2uM9zFYBgy488FKAD324dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1MGzifU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A003C4AF11;
	Fri, 21 Jun 2024 06:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718950302;
	bh=Rt3SceI+3WtSlghMCrF4xk0O9VqqF+9ICLfLpATWNzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1MGzifUh0Eybr7LicxuunGIVvsXGMVJFctpG0AgcExsUQ1zc5jsMgiZ93ea92RiF
	 OcQaFDCA9ZR3M54BUjDpfQYu7TmnBtGdjLG7QjEI+3H+ZFzL4e4Q++7S1aic0G7jQ8
	 poCeuwyoHiT7vEAyZ9WQbI4i2/NSkjTK1enWHMkP95Fm8W0TOAA65uyzG8KOeOUAMN
	 i1JqHbOkiJOPD+1222Z2o+3Wi29rlRGel8JCb09Pz64dRgp5YZkT4IWH9iyjbOnrA9
	 8yb/4x64ZcthxRWAYkwxsiqJvX2jwFjm45RiMSe64GDYuUFl/gGP7JRi5j+vOySoX6
	 szWrlOufxYIkA==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Remove QCOM_RPMCC symbol
Date: Fri, 21 Jun 2024 01:11:24 -0500
Message-ID: <171895028805.12506.8367685063587068019.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619-drop-qcom-rpmcc-v1-1-b487c95162ef@quicinc.com>
References: <20240619-drop-qcom-rpmcc-v1-1-b487c95162ef@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Jun 2024 08:41:52 -0700, Elliot Berman wrote:
> This symbol is selected by a couple drivers, but isn't used by anyone
> and hasn't been for years now. Drop it.
> 
> No functional change intended.
> 
> 

Applied, thanks!

[1/1] clk: qcom: Remove QCOM_RPMCC symbol
      commit: e429be706f2a1bd0c9a780793fff6b3784fb4204

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

