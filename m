Return-Path: <linux-kernel+bounces-171225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882208BE166
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F66F1F23860
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879C156F31;
	Tue,  7 May 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMbEi+OX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF815253A;
	Tue,  7 May 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082552; cv=none; b=bM1ID8xbcWOSlzk4404Luj2s7Q1cuL2EcAw8tQvjlMeAlSqae0cT8VEtQWUNi2mjbS+LVSyZoqenTnPmfCPOlygkaOPZwrdeuvEZ820SASc6G0ixpJ1Z5HK/nHZXN5gsTSUh0ymv8uX+f46ljBrB6z/cpczpdyLm/+o+IvI7PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082552; c=relaxed/simple;
	bh=x4xe/G+hM/H9M+YCEDwIrs1hK78BgqwJzISru/tjRu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjbEcDcvZvC4hqxuB9GS58AuTn/MGNhQbC8ex6T0a+wL2RaH3nx3jCGNu5io9oyzPWxmb4YfHXtJSny5NR2mAsC/6Wkay9ySlOLuNRVS8iA6dcvc4FU7su/wJ4XheygOcbiCXvGB5G87Hy6cjbqXj1JiddF4j3TOYgRtqaVvFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMbEi+OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF27C2BBFC;
	Tue,  7 May 2024 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715082552;
	bh=x4xe/G+hM/H9M+YCEDwIrs1hK78BgqwJzISru/tjRu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WMbEi+OXL7f+XnOs5vqNMtVHXOQB6nVMnzNsjX91jA50aFI0OoAlCirdPcQcQNPsk
	 hRl0hw3HM16WY28qkTvsB/ioJFt/T6iIeBQVlwdW6DdNkHubYNj87POutQkglKTQAO
	 6GuqBLiX5nTXgAkfuyeBEZdGmIqSkfa6pIzoj6O74MObNT7Z5KUslLXPxNhUbtU/7/
	 RxnizgglO8XE3GceBmPyzx4dC2tgDz66WQsptYyqRp2hL94iYSFc1HDxmfCtgWhi1H
	 yonYQxjTcbz3ndw8GBksMcWAlf5/a+Qc3JATx60Wpk6UsFkz+u0x0vdviQMAOGojPI
	 fXg9epNEKk0Ng==
Message-ID: <e36fce80-a029-4a4a-a09e-43fe39485d3e@kernel.org>
Date: Tue, 7 May 2024 14:49:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-j784s4-main: Add support for
 USB
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507095545.8210-1-r-gunasekaran@ti.com>
 <20240507095545.8210-2-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240507095545.8210-2-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/05/2024 12:55, Ravi Gunasekaran wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add support for the USB 3.0 controller
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

