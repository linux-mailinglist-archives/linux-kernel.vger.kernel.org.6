Return-Path: <linux-kernel+bounces-573987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83EA6DF48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF17D3AF437
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C425E474;
	Mon, 24 Mar 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUPp+PgA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5725EFB8;
	Mon, 24 Mar 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832560; cv=none; b=DanO3YXg2Qw5P8EnOeCxeUi0Fce8QC6+mlt2ejQSzuN+/TENtX3VVNYHBfkZ/8EebetYSOm506y9geekHq+qTvbkqlOK10T3xijBdTXruMiLJlHupVUBQ8sy9U1sebHdWj00WY5FeGgiREyOvlGfwvDLTK4FJf6fHedAjl/BktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832560; c=relaxed/simple;
	bh=dW2mHsbafla5tl6HOgIHdUFxukxCuwK2/r4vlOcdr8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO96JkC+PeusYxCNmMdAgVE3032t6u0JtdcXEoM51kf7MKOVPbRivYTuLrJIlmiLoxV/p34vfYXvavx9C0mbovM9yNPqyrersFr+8oYcxdTwenI2zf9M88P901qbkSuaqnxnHytrBc+4gJtf57h7ivEpZBPLOYP8bhyVuPDZSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUPp+PgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5A2C4CEDD;
	Mon, 24 Mar 2025 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832560;
	bh=dW2mHsbafla5tl6HOgIHdUFxukxCuwK2/r4vlOcdr8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUPp+PgAEdBUUGJc/nn3Elx1H0pmey+Jw8QUF0dnOwRbWrXkVACB8QoZ5MxkMRWBD
	 fRQPlwZXjLNphZxUCNeKGlCqFzhnJ0P4WMMnqLNxokjxEij+N3iIs5cH69ZgGW09rK
	 Fk9O0sQlNtVlBlF71VJztkrjx37Wi+E9V1uvaj5J5AEPpWUqFuNm5pXbsuHaVY9nq2
	 83YvPbnz+Pfz5gFB0CbS6UnYiN38MZHeDdLNYAAfCwc1XxJS2ECf5Jk3neQ+qOh/WO
	 LP9kJCna2jQw4Ic24uvOVY+PxJtMsyntWVxJNCiHHsVR2tC8IQwnvzx/qjaWaFLivm
	 3bO2pjEvCLHkg==
Date: Mon, 24 Mar 2025 11:09:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Ultratronik
Message-ID: <174283255844.156394.6968260022481776351.robh@kernel.org>
References: <20250321111821.361419-1-goran.radni@gmail.com>
 <20250321111821.361419-2-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321111821.361419-2-goran.radni@gmail.com>


On Fri, 21 Mar 2025 12:18:16 +0100, Goran Rađenović wrote:
> From: Goran Rađenović <gradenovic@ultratronik.de>
> 
> Ultratronik GmbH is a German electronics company:
> https://www.ultratronik-ems.de/
> 
> Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


