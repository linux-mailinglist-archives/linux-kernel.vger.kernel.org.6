Return-Path: <linux-kernel+bounces-189968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FE8CF7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DEA1F21739
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E413C3D2;
	Mon, 27 May 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk6ZSxkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80513BC11;
	Mon, 27 May 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778877; cv=none; b=Rnum2mAOwvNurkUMImkSB8EsQE8+opw+k0yt7yJnw/TnheHXv7l2fTYpE6olcXmfKolAdxVxSRw1bgJuRn9JWvfSHTDshak5oQmFmvBEDpa+yQ6G6skN14YGaderUgS255zx0cjGa6tNRrAYGniKE1UoDjErrDu4LQPvPO+dqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778877; c=relaxed/simple;
	bh=zffqylxuxAKWcLxvVsPxjwR+Jja1cYzzz99On3P8ieg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2ANzuu6HK9FKPCSEX9m/Np5gWm1sjRZ+ucrRbH5HV11CPiew0Vihfzp5l99J0mv63WrnTaFmx4umqKdOaFuY0T9LhxBDwkfpQSTtvvr1kiHwJ+JlFaI4g0ys/SojXtlxy2RxgzUkwRbclQpl9fh3urTYNHEdr6Gi9iP+giG5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk6ZSxkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D36C4AF07;
	Mon, 27 May 2024 03:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778876;
	bh=zffqylxuxAKWcLxvVsPxjwR+Jja1cYzzz99On3P8ieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qk6ZSxkmsCNvQggXT0bfBXz2SN/YP8fFDj0fWt6RFFq7Sv8RywBnnWS4jIuvfWehW
	 gKQdQVtJjnCia/TalW3TrD3EXzojZDeYhWrttLh5gaZhBdWLuxOlrHwBsYmLoaLhsx
	 GzhJGic4yfXhceZJfrXH4YdhhRBhb8pDoXVPOrj05Vic4oz+XNjJfU1w4voY1o/G5k
	 W2SrYcD9h/5FvNQZjp7KPyIiKdqHq4T9l0kUCI70foy5ayOZqb/3FvZtfiwSCS73FG
	 ngoCXe0dtwhakeXjajAzKaQzTWHnDdbqOE3B3+n8WGTuZMhCmhNo+Fi+BQTNX5AJu+
	 ChPfNOBWlhFnA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com,
	quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
Date: Sun, 26 May 2024 22:00:41 -0500
Message-ID: <171677884200.490947.15482010782632522164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424054602.5731-1-quic_vdadhani@quicinc.com>
References: <20240424054602.5731-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Apr 2024 11:16:02 +0530, Viken Dadhaniya wrote:
> Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
> buses usecase on RB3gen2.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
      commit: fbc7a70b2c1b03eab1ba4a0d611867a2de23d142

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

