Return-Path: <linux-kernel+bounces-289644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9179548B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF44D1F24013
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0811AE873;
	Fri, 16 Aug 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQhehuzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4212AAC6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811183; cv=none; b=qycyLa1Q5fiL7W6k/HwBDKAiFk3VPedGxsJBLQX+t5vVl7A5X/nLpma8Qyju9i7e5P1LdQb55xoiT37qTW6yKGqEAKNkwGBNlp5rMnPai4tFsJjC+MgMDGN3mRE9iFdEwTDsiCqt3iWUPnQa5ty6MRaBTdSdhk7saDE6iADKOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811183; c=relaxed/simple;
	bh=HMNiKhgEMzC8vQswXZUWYIvnLzZglYzYTD0GACczhv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M20H0gvTOPjowyV6NZjpmYsXZuHFt6v28pKFTWlEk/KBnULATzkOUAXcs6DRFSC0YuGq1QGneJQ+KYd5U/hlSCxJRtVWPuoriK2iCz9XAPFmPw91XlvON2lYYFmNECVgtOkEWjw8y44GNtqxKQR5ssJZF4jwMqGqwSk8CWxxSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQhehuzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6216EC32782;
	Fri, 16 Aug 2024 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811182;
	bh=HMNiKhgEMzC8vQswXZUWYIvnLzZglYzYTD0GACczhv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQhehuzU6/dgZBpI3cU2OD2gg5KUQJKn/APjU4UA6DBVnQA5iPM0PXVvaxXjuydUL
	 WZ+3YH0Fqf121LS2MAu4FIovocWSVQJdLpChf6Z2dpiie5Kc+e87KryM35x8aXPUaw
	 F1cYlJyWbZ7h8lu4s5hEw0Hn6/FI6bu4rYBluuLe9T7i4a0tLshsNGacPiqsqSqxEJ
	 0iOTjthxN1E0BVGoNOC8ohC8kDrDTOzOBBaNTNTiHU3ZPc9oV+s+TJFsL4FEhhsn8Y
	 +eXXOCO8Ihql++Fm/GBv4Tgkb9IIZTOJix69PuSwj48WDqxjS6NuS4rtLYT1cDp706
	 xChhBZ1gNoFrQ==
Date: Fri, 16 Aug 2024 13:26:18 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, gcherian@marvell.com,
	sgoutham@marvell.com, bbhushan2@marvell.com
Subject: Re: [PATCH v6 2/3] perf/marvell: perf/marvell: Odyssey DDR
 Performance monitor support
Message-ID: <20240816122617.GC24137@willie-the-truck>
References: <20240704092022.1136805-1-gthiagarajan@marvell.com>
 <20240704092022.1136805-3-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704092022.1136805-3-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 04, 2024 at 02:50:21PM +0530, Gowthami Thiagarajan wrote:
> Odyssey DRAM Subsystem supports eight counters for monitoring performance
> and software can program those counters to monitor any of the defined
> performance events. Supported performance events include those counted
> at the interface between the DDR controller and the PHY, interface between
> the DDR Controller and the CHI interconnect, or within the DDR Controller.
> 
> Additionally DSS also supports two fixed performance event counters, one
> for ddr reads and the other for ddr writes.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 248 +++++++++++++++++++++++++++
>  1 file changed, 248 insertions(+)

Please can you add some documentation to Documentation/admin-guide/perf?

> @@ -314,6 +420,14 @@ static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
>  	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
>  		*event_bitmap = (1ULL << (eventid - 1));
>  		break;
> +	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
> +		if (ddr_pmu->version == DDR_PMU_V2) {
> +			*event_bitmap = (1ULL << (eventid - 1));
> +		} else {
> +			pr_err("%s Invalid eventid %d\n", __func__, eventid);
> +			return -EINVAL;
> +		}

This 'else' clause is identical to the default case. Please either add
a shared error label or have a fallthrough. We shouldn't duplicate the
print.

> +		break;
>  	case EVENT_OP_IS_ENTER_SELFREF:
>  	case EVENT_OP_IS_ENTER_POWERDOWN:
>  	case EVENT_OP_IS_ENTER_MPSM:
> @@ -439,6 +553,7 @@ static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
>  
>  	val = readq_relaxed(pmu->base +
>  			    DDRC_PERF_REG(p_data->ddrc_perf_cnt_base, counter));
> +

Random whitespace change.

>  	return val;
>  }
>  
> @@ -459,15 +574,43 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
>  	local64_add((new_count - prev_count) & mask, &event->count);
>  }
>  
> +static void cn10k_ddr_perf_counter_start(struct cn10k_ddr_pmu *ddr_pmu,
> +					 int counter)
> +{
> +	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
> +	u64 ctrl_reg = p_data->ddrc_perf_cnt_start_op_ctrl;
> +
> +	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
> +		       DDRC_PERF_REG(ctrl_reg, counter));
> +}
> +
> +static void cn10k_ddr_perf_counter_stop(struct cn10k_ddr_pmu *ddr_pmu,
> +					int counter)
> +{
> +	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
> +	u64 ctrl_reg = p_data->ddrc_perf_cnt_end_op_ctrl;
> +
> +	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
> +		       DDRC_PERF_REG(ctrl_reg, counter));
> +}
> +
>  static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
>  {
>  	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
> +	u64 ctrl_reg = pmu->p_data->ddrc_perf_cnt_op_mode_ctrl;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
>  
>  	local64_set(&hwc->prev_count, 0);
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, true);
> +	if (pmu->version == DDR_PMU_V2) {
> +	/* Setup the PMU counter to work in manual mode */
> +		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, pmu->base +
> +			       DDRC_PERF_REG(ctrl_reg, counter));
> +
> +		cn10k_ddr_perf_counter_start(pmu, counter);
> +	}
>  
>  	hwc->state = 0;
>  }
> @@ -526,6 +669,9 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, false);
>  
> +	if (pmu->version == DDR_PMU_V2)
> +		cn10k_ddr_perf_counter_stop(pmu, counter);
> +
>  	if (flags & PERF_EF_UPDATE)
>  		cn10k_ddr_perf_event_update(event);
>  
> @@ -642,6 +788,61 @@ static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
>  	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
>  }
>  
> +static void ddr_pmu_v2_enable_read_freerun(struct cn10k_ddr_pmu *pmu,
> +					   bool enable)
> +{
> +	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
> +	u64 val;
> +
> +	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +	if (enable)
> +		val |= DDRC_PERF_FREERUN_READ_EN;
> +	else
> +		val &= ~DDRC_PERF_FREERUN_READ_EN;
> +
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +}
> +
> +static void ddr_pmu_v2_enable_write_freerun(struct cn10k_ddr_pmu *pmu,
> +					    bool enable)
> +{
> +	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
> +	u64 val;
> +
> +	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +	if (enable)
> +		val |= DDRC_PERF_FREERUN_WRITE_EN;
> +	else
> +		val &= ~DDRC_PERF_FREERUN_WRITE_EN;
> +
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +}
> +
> +static void ddr_pmu_v2_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
> +{
> +	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
> +	u64 val;
> +
> +	val = DDRC_FREERUN_READ_CNT_CLR;
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_clr);
> +}
> +
> +static void ddr_pmu_v2_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
> +{
> +	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
> +	u64 val;
> +
> +	val = DDRC_FREERUN_WRITE_CNT_CLR;
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_clr);
> +}
> +
> +static void ddr_pmu_v2_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
> +{
> +	cn10k_ddr_perf_event_update(pmu->events[evt_idx]);
> +	cn10k_ddr_perf_counter_stop(pmu, evt_idx);
> +	cn10k_ddr_perf_counter_start(pmu, evt_idx);

I don't understand this. Why are you calling _event_update() when
cn10k_ddr_perf_event_stop() already does that? And why are you calling
stop/start back-to-back after the update?

Will

