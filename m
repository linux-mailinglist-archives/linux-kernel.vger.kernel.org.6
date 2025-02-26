Return-Path: <linux-kernel+bounces-533987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8ECA46125
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1C16AECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D322171D;
	Wed, 26 Feb 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkoVsqQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD6219E86;
	Wed, 26 Feb 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577259; cv=none; b=OffOH34gP+alRQ5JKrfPdidO8AmPB2HiLqi8+Ffz7BUj2jjYENpxyq5lUU7UNydQ94lvOGEbM9wlPcNMz/LHboF5xz9OERh6mp70hZ5LS8soNAwSSdE1sMxTlJaIiLOdvlfF0byR+4m4Le4RGWWwsPSHxCGDIbHGRtWgQ2Aw8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577259; c=relaxed/simple;
	bh=EiDghBz5rOWEkCy7DfK1X7QaWLd5nUQck1/JK+pH5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQt7ysmjQLGby+YqIV71aFdUWwtJupK3if7LRrw745VCmKZ1hxfbAiXVzwDt6eJuXTqO6IPw8pKFWAFXNGBIwLvt86Xnjt/SJ5pptAAe8/CN+Q3SSGXpedH6UHwpnzTN2+B5Z9jABty49mm3e/Cf8yBnU4rcISG2AgiAljeJfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkoVsqQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C56DC4CEE8;
	Wed, 26 Feb 2025 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740577259;
	bh=EiDghBz5rOWEkCy7DfK1X7QaWLd5nUQck1/JK+pH5PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KkoVsqQsiXFZriOBmPuWDNF4035dKvy6VvPiyroXJAbCOP6EoVtSrK5Sk9uVKjEfd
	 msHXGBznQxkMOrbUdmGxSu69Yl9sj50u9PrAQgCK4ocTt6Eo1GUTz4u4MsPuHmRasv
	 JD4hVBCMEuWiJ7pWL3Q+PfwEbS48mL9jf5JYm/9FIeK6EUcbTFSpu/DG72emy4GnDl
	 BxfAn/8XJ3TUF+0V8PeG41oxtQSAVC57y8KQpSjw9kvhJuOo9hRwsGKmCu8ImciDLi
	 aA8QxVVuRrXo5+1248zFFqMGzswQmnbC6fqHpGiHR1sQ2UPNs2Q3DeX/EJbi8GJkjk
	 wBhGC54uJQbyQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com,
	quic_anupkulk@quicinc.com
Subject: Re: [PATCH v4 RESEND] arm64: dts: qcom: qcs8300: Add QUPv3 configuration
Date: Wed, 26 Feb 2025 07:40:49 -0600
Message-ID: <174057724680.237840.4730026381777923841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224063338.27306-1-quic_vdadhani@quicinc.com>
References: <20250224063338.27306-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Feb 2025 12:03:38 +0530, Viken Dadhaniya wrote:
> Add DT support for QUPV3 Serial Engines.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcs8300: Add QUPv3 configuration
      commit: 467284a3097f4348cf227053b53eb1bba2af9ae5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

