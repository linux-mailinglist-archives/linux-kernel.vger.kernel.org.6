Return-Path: <linux-kernel+bounces-427937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8339E079B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D21282104
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B9185B4C;
	Mon,  2 Dec 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoTbDtMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483919E98E;
	Mon,  2 Dec 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154683; cv=none; b=Jk08EQ/LyeQICtzyhNwng63FpLQxZ7iDU3Zwomqvoj7ze1pqiwp/TznwWWwdaSCSAPpWV9iqwALeNIr8ULLOcjcVGrkEdBrwwn+HIO5xZaL3jXUZAxMu92v9xPYFjcJNrRdrkC8dn4xapR9DoRbrUU9YJItm5Vinq1481QeboYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154683; c=relaxed/simple;
	bh=CnpPH2UfsexBXnHNUdqCFYywSZ1w0kC/wjaUG7y9kLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bfeg+bDEXGWlJyIYXSiHLAN3Fo2xzpZPCQlTlIWkyAJyRuf7h33Q1UZhSFmuKuEACcbFfJM5aIfTgg5FhsGotDYSPQO5wiXFnZZ3UlQssY2c2coAvDdVIkPMb1T0PBGlUqSZZ1LDFGElt/y7wod8DkCh48IL852KyMO5pKhNMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoTbDtMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21E4C4CED6;
	Mon,  2 Dec 2024 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154682;
	bh=CnpPH2UfsexBXnHNUdqCFYywSZ1w0kC/wjaUG7y9kLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoTbDtMbazI+K7+JVh02WoAwUijeuD2pkHGf8DJT8s0dpyFpSC9tYLeD6K4YcXz0d
	 E/AWa2f5XrXq18qoWeSBnju8Pe8LVnFa1j5Nda5J1DMe4ZK62+MpBe5mCXnUkMpqbX
	 JuUniELjYDYahWglm6auR04bmCEdnXuRJrdNK7B1J68zTF02Ie22nCcDkFAlbts3zW
	 m/ajfg4QrY2yjxXWujzu3Dkkyfguf/NYApfLhYDfjuwo0Tc+qDDGymh1ghpwRpnz4T
	 /xKN0nAfgsyen1W+E4XFpCJvUR4XBYXnMUjZKFuebjB8Z5bZTFd2w00Kc0zN7SzCG8
	 evw42E4FSlZZA==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	dmitry.baryshkov@linaro.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com,
	quic_anupkulk@quicinc.com
Subject: Re: [PATCH v4] arm64: dts: qcom: qcs615: Add QUPv3 configuration
Date: Mon,  2 Dec 2024 09:51:07 -0600
Message-ID: <173315466531.263019.6529566913166074928.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115101501.1995843-1-quic_vdadhani@quicinc.com>
References: <20241115101501.1995843-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Nov 2024 15:45:01 +0530, Viken Dadhaniya wrote:
> Add DT support for QUPv3 Serial Engines.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcs615: Add QUPv3 configuration
      commit: f6746dc9e379eaaf832f326b233f94a95ae03027

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

