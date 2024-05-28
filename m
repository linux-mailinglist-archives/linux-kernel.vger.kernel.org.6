Return-Path: <linux-kernel+bounces-191710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD698D12EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AD0B23039
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA11411D9;
	Tue, 28 May 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upio8Eso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED7140396;
	Tue, 28 May 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867195; cv=none; b=HtjpueXiUYer0V5r4o9pxIjr9zyo7ujz5D7BvoMdKA/EKubr+kVYoT8iXG4OGHFAYuSlqq9shEPTANfa04bDqIx47QmpXv0+WVibpD/vtGKVMgr7F4Svz/mfChte9bqvC/iaEtAWkER3STMNy3yfUCfT6YwsUdr4yMddxxDqZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867195; c=relaxed/simple;
	bh=tKlsMVR7o5d4zENqptMhGwHTEraPztaGvtFA3hVgHPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aygUKTqhXfcueCxkX1JMXd99jC032vMWxAVDLA7+ZgdVTiBtx1qfxifj5T2koGxVihTPCKcePjxyGFTcelbFenq3xqE9WDZJAcCChIjG2W2XUpagof343mTmmzeuQuFndj2nGXKHthJZ0MHkkLOze3kVmhh9xBZ06llT0sPS1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upio8Eso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F195C4AF07;
	Tue, 28 May 2024 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867195;
	bh=tKlsMVR7o5d4zENqptMhGwHTEraPztaGvtFA3hVgHPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Upio8EsoDmFXydLwo0RvLYQHMaZ/U2uzY+g5590kd+QvNUuXcMdiUbyCW+WVmqD7D
	 YKcszuMKoJzwpaWTcsjwuSMLju56u2ridu6Q/zm1WmnW51190oqqf0dLcc6JH/v14Q
	 nQMzUyfV20SIlHfpFehFdIDul6PfVNxrQPeG3bRVwOgCC6AkcuABIAyl+jsI3y93cO
	 zxEdweWhJU1fuTyJu4kED8RLLxDIcdwSmqxCmiMq+DYNtzsVQ8/e9Ayv/K/eRXPOw+
	 RzoMdPNZSQtNjKTJjTlqhvwj/+HPIs22ry4IJsD46IHlO6xsM7G+IRFg8h7Cw4XfuT
	 SOBlxWQzcrsDQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] firmware: qcom-scm: Remove QCOM_SMC_WAITQ_FLAG_WAKE_ALL
Date: Mon, 27 May 2024 22:32:34 -0500
Message-ID: <171686715153.523693.9390441438400275150.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514180046.543763-1-quic_uchalich@quicinc.com>
References: <20240514180046.543763-1-quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 May 2024 11:00:46 -0700, Unnathi Chalicheemala wrote:
> This flag was never supported by firmware, so remove it.
> 
> 

Applied, thanks!

[1/1] firmware: qcom-scm: Remove QCOM_SMC_WAITQ_FLAG_WAKE_ALL
      commit: f63f815fc2a5ca9d57beba0286aaa82bc3277353

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

