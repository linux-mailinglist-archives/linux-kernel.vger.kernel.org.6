Return-Path: <linux-kernel+bounces-211792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796CB9056E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185472860F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AC1802DD;
	Wed, 12 Jun 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Z5mNTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014818622;
	Wed, 12 Jun 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206344; cv=none; b=f5RHlvS1L/lCxEisZXHx2kilYBqoYUvkikhPanLB2WVxAZtQ2BYyuEKOu0VcKbU47jIWhUYxoSIuIA5we/NNrtfXtAJ9CWjNTuxX5TbbQcLzQmxi0A5BO0mezU9bj+ezziHi1RBHXU8mNlFEDHqo9CjvgCEG26KyvHTxlJPOK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206344; c=relaxed/simple;
	bh=OGoAB/KsV+AVM08lTf3vOHxawWYqkPNBMZeu15j3ez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg2FYWdsk+gz5ezEGKZIyHEuig8YYN2p4Anrsxz/4xB9jLX0erk/jbQPARZr8STkureUj1HU0Cs7+hAMGjmBXDElWLsIrCp+hXh0UYt5N9sWtI74IFc7wpKnS9sldgDbxRUNnBK+W9g3ab6OJ4b/GbxsXbyzy0Gppu1jkIcu9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Z5mNTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9E0C116B1;
	Wed, 12 Jun 2024 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206343;
	bh=OGoAB/KsV+AVM08lTf3vOHxawWYqkPNBMZeu15j3ez4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4Z5mNTpKKY3xFAj4m+68IihUDu6UXEpldEukwcXEyOLneAb5ZecfvI+rtrMwS+9w
	 ugYeExRaz8FwnwpL95FTS0e/C3ZZB7hS0FHpRrOBaWWsXdv8RZdiKJNWwVLDsNypHf
	 EBbwwMntPG1VrcqLBBVP4qdLnxRyDgV7RIlI1pNNEoqRZ9/Re8ebwc+ZC+sZf7hbXL
	 VJn1kKOodoymSuJ4k1qjSQNh1IkZJ6G4XkQkP4DI68gIl8R5mJ6Z9Kt7pRDHaLRufY
	 ZsFruA6FvyfeCmI/mJhuz52rTZeg/qBUGR7IiInbbDGqeVVgSfCVj9s78+8rjpqyUO
	 IlvstsMPQ1GVQ==
Date: Wed, 12 Jun 2024 09:32:22 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: Add sc8180x
 PDC
Message-ID: <20240612153222.GA2635484-robh@kernel.org>
References: <20240525-sc8180x-pdc-binding-compatible-v1-1-17031c85ed69@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-pdc-binding-compatible-v1-1-17031c85ed69@quicinc.com>

On Sat, May 25, 2024 at 11:05:31AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The SC8180X platform has a PDC block, add a compatible for this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied.

