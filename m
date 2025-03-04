Return-Path: <linux-kernel+bounces-545082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02CA4E8C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20B34236D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505192D64E2;
	Tue,  4 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5ld8T0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AB294F0F;
	Tue,  4 Mar 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107626; cv=none; b=i5DDZrNE7MHu+BszygfZ9C8nUMnnqU8kFQ4fmcziPtlYvlP7aDcNJt0r7z1vQu2mF0bvV8WBcG3Q7AXolrlu81boKbqReejg8sZ4y24lWhrZqmKG5J5gSg7EDiBlPLWkZKXe+kEZPVy16FiMw3XgOd9S9g2RwnAeGWAG49hkgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107626; c=relaxed/simple;
	bh=a0KsAqx36piFh1iGUFybe3DhePhOiWgbqKDpC7t5My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l06WheFKGaETVRAFc1WHxT+0SmodqmwdawNTzgCJp2XLarp0A0MgN3e//ge5ehMuMQ/QcBf7dg9hqTvjuSq4MgUgMl+ikEx9syFhoC/0dGbFx4IIXxJ27/5dEch4wUVsmaTdx5ks2dxMzDyCsPwKWKeqq360Zi30EgpWvX2llTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5ld8T0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B08C4CEE9;
	Tue,  4 Mar 2025 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107626;
	bh=a0KsAqx36piFh1iGUFybe3DhePhOiWgbqKDpC7t5My8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5ld8T0yyfFjrZ4/28c7l+hsPXd76f8l4Mcc7BqZ5T5Y/0ifz5eI2zusvlUR30K2r
	 9DWPzq7LFYcydwF3YWvlkejUi4lKiex+WvnE89Cfb6JxaTSZrB/ZKNltARYoOWpa+f
	 8loU6vTavsxxrPSqPAPv+ZTMwAAaTG8HH5/Xem8FLUFpqTqScFNSZqzMAPDG489Kvu
	 v6khZpaRKZAkF1Zux7cpFzWO08dglGjsdZDxGkY6wEoy+d1FfHTdufci/bJfCmvmcM
	 KnZi/Wdqk3GQS2R2U6nvtwc2dLsvfvkAmJyQjkxKcZzmwLItc8uzDg/OBHS9BVmfIo
	 T+/D0r0SNAA4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] {vision/navigation}-mezzanine: Fix overlay root node
Date: Tue,  4 Mar 2025 11:00:13 -0600
Message-ID: <174110761298.741733.13300638757962202503.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227-qcom-nonroot-overlays-v2-0-bde44f708cbe@trvn.ru>
References: <20250227-qcom-nonroot-overlays-v2-0-bde44f708cbe@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Feb 2025 19:26:47 +0500, Nikita Travkin wrote:
> While considering to propose WoA EL2 dt overlays upstream I was looking
> at existing overlays and noticed that some of them are broken: they put
> seemingly meaningful fixups into the overlay's "/" node, which places
> them into the overlay "metadata" itself, not into a fixup fragment to be
> applied to the actual dtb. This series fixes those two by changing to
> full path "&{/}" which should work as it was initially intended.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Drop CMA heap
      commit: 2a26a02e668ff101580647221c898d75ed93f8f5
[2/2] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Drop CMA heap
      commit: 4de3e8d657f2111dd8d45c2ba0eef8b2437b85f2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

