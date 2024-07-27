Return-Path: <linux-kernel+bounces-263808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4A93DABD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72E6284018
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01771154454;
	Fri, 26 Jul 2024 22:39:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4951527B4;
	Fri, 26 Jul 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033557; cv=none; b=ZKkOwxH8SVU7NfA+wgbTarMft23ExWowmZtfsVBHYKMI4mZeIUZMZ+REGpc7cosOQUBXMy+98vQV/51yHUlz71IBJYzWa1DT+DHeNFFGKwmBWQwvcX8WG2D6MlBsu+UIEfQwrLdWHc2SDUZ5cIRtM5psFflGYMns5u5i09XAj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033557; c=relaxed/simple;
	bh=ZypOPMYT7LnQZE/cklTe2XVxU0bVptXb5S3g48F+Qmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hFvUIS9LWqq1/G3lN0lxp8UGcR1W74Fnmty6LT356MfZzofdNu5cot7OOSIEnxVS0HQoD60Oyu3vhn5LHnYi01+JgbdqIKI3EfWFm8M98QTUvbWmPdijOj2bxmbeM4Bpfbhxx32jhJQWsPVD0t8oTUP1ihKqQ9bows29E9z2zZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047AC4AF0E;
	Fri, 26 Jul 2024 22:39:16 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7142E1060981; Sat, 27 Jul 2024 00:39:14 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
References: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Ignore extra __le32 in
 info payload
Message-Id: <172203355445.246603.641268123308931375.b4-ty@collabora.com>
Date: Sat, 27 Jul 2024 00:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 12 Jul 2024 12:00:03 +0200, Stephan Gerhold wrote:
> Some newer ADSP firmware versions on X1E80100 report an extra __le32 at the
> end of the battery information request payload, causing qcom_battmgr to
> fail to initialize. Adjust the check to ignore the extra field in the info
> payload so we can support both old and newer firmware versions.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Ignore extra __le32 in info payload
      commit: d6cca7631a4b54a8995e3bc53e5afb11d3b0c8ff

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


