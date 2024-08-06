Return-Path: <linux-kernel+bounces-276466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09A949426
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074BE1F26EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7451EA0DC;
	Tue,  6 Aug 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzr3DGZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C81D54FB;
	Tue,  6 Aug 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956709; cv=none; b=K6melYKVbQBaBTvki9aQ8rUEnNOKrqKTUcc+BAUewm0N1gpdi+yx9GVTBRrrTeOuXoFXkPti0UvSaEQLlWcX1I5k97WqFPpMxVDevoGNhLdKbUbMpNthbBHrLFqLmaYwNnqpaqSYMPOfwRClkhb3tF3Hme6xI0WpvjKyxAPBS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956709; c=relaxed/simple;
	bh=2yZTrDqUX4cbeEWUZZcepAZ+rm3PXu+PP2tqkUoTQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqtyxFPwAjEqdxLGEMUFcfHIU4sQGBseY9SiWZBdAgWlhe8eJMKf4yf+KfPnsvtcEvfin0jS9Pl+FzogyqI+aZgrWxIgGuPq82pth68pEC+9AvzGbaOTYEi7AUrJLzwl6N+KHM5APeAGqLcdfH7xR414HJbsPx3i3p+Y4K46ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzr3DGZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC26CC32786;
	Tue,  6 Aug 2024 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722956708;
	bh=2yZTrDqUX4cbeEWUZZcepAZ+rm3PXu+PP2tqkUoTQuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzr3DGZwmDisJAZoWjhEHney8AYqVCFkw1v99mWtchmgDnrBeOjDVKw7OiCiBp9Xe
	 PkvSP9Io+C0UYiBu2DLn4JXrjyhyY1WKW3gVd3BTAfc7kIBSZJBUMsD9Rr2XKzWope
	 4fPML74hQhxaIIf/B2jH3NhISE9XhQuVwSJmOvhihTpTivVNcOECdz/zGUcBPTIzuy
	 jgTO/2+1fNlXCe3u+DkQ2muNnu/Ge1wxtf68UIjS1vuQN42uJVCV3RaxJJ9m3C2HEO
	 6u47pQuWpw3qJTtdWsfeunFxCSAVxggcBDQCW3SR4z8obXUy/G1wGTTqDLcvWXWFYD
	 RHjnWhZDtom6Q==
Date: Tue, 6 Aug 2024 09:05:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: timer: fsl,ftm-timer: Convert to dtschema
Message-ID: <172295670644.1526916.5235199527957758747.robh@kernel.org>
References: <20240730171336.99090-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730171336.99090-1-animeshagarwal28@gmail.com>


On Tue, 30 Jul 2024 22:43:33 +0530, Animesh Agarwal wrote:
> Convert the Freescale FlexTimer Module (FTM) Timer bindings to yaml.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../bindings/timer/fsl,ftm-timer.txt          | 31 ----------
>  .../bindings/timer/fsl,ftm-timer.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


