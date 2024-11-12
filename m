Return-Path: <linux-kernel+bounces-406416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01D9C5EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DD728297F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673AF214422;
	Tue, 12 Nov 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmk/ylIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF799213138;
	Tue, 12 Nov 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432030; cv=none; b=NqWb/8PooouvaixA8pR/C1Mm4KOzAseo1MVpVDjxVQA1HisV+3Hkfqziekm93s+vDHKddjpriYq1F+WlEkROAfR9dmEtiYzKgiFfx1ENONKQyDUYK8D8fea8IV+KdwxTpGY7za7KgWV8S6QG1wgc571fx5gy/UbI7Eyh8Yi+LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432030; c=relaxed/simple;
	bh=CXrOHc9JBCiVglPvPz3sc/dEozXD5q3Hgp7nVaLE+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foPTxCE6zsSkZjh8jr6NRxuadS91aplo++o3iweV1cj76uUlSUS3oEbCIRy1tDp3iFeaRqwzW/sI0eL2WIEeN1fR9HFlpYWYHosIaqBn/quShVH5LKYsLgA3rwcvyR1IcwyOJHSFvE4cjCliUX1ozlcYv1zU6OBPshps6vA8+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmk/ylIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A02C4CECD;
	Tue, 12 Nov 2024 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432030;
	bh=CXrOHc9JBCiVglPvPz3sc/dEozXD5q3Hgp7nVaLE+wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zmk/ylIKuPANhm6lQ1e7O7L+aEUWBlJoddI3O3ylK46gTMicUflYmEjmnRgFMRiDz
	 mj6unpzOLK6NzGBofZvyXNY6kN2oP7bEgyuetIRrOr82E069ZSo+NOHqr/WPY0E5qc
	 Qftj6nuINA40qdM0JjhZw0dYZdzL39RKYf4zR6SSqyh1VJzPcT8eqcAA9qyBoD3QzG
	 I8gLguJXk7M2WfQlDZH+koLHuQO+hFf6fvgqI6Rm/DYEkABiN0iv/GhTS2jlgu2C40
	 O/SsU+jiwngoiNjOQD2VGF4xXCiKn9w0qybBxYdZqu7ZIjUwzMPFYtGYuCcr4LdnNM
	 RJMjj1fNvj08Q==
Date: Tue, 12 Nov 2024 11:20:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: Correct PM8550VE
 supplies
Message-ID: <173143202800.1356694.128701618533783136.robh@kernel.org>
References: <20241112003544.2807368-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112003544.2807368-1-quic_molvera@quicinc.com>


On Mon, 11 Nov 2024 16:35:44 -0800, Melody Olvera wrote:
> The PM8550VE has two more supplies (s1-8) than the PM8550VS (s1-6),
> so move to a correct if:then: clause to accurately reflect that.
> 
> Fixes: 902f8c9830c3 ("regulator: dt-bindings: qcom,rpmh: Correct PM8550 family supplies")
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


